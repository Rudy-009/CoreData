//
//  MemoViewModel.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import Combine
import Foundation

protocol MemoViewModelProtocol: AnyObject {
    func transform(input: AnyPublisher<MemoViewModel.Input, Never>) -> AnyPublisher<MemoViewModel.Output, Never>
    var memoList: [Memo] { get set }
}

final class MemoViewModel: MemoViewModelProtocol {
    
    enum Input {
        case addMemoButtonTapped
        case editMemoCellTapped(Memo)
        case viewWillAppear
        case fetchMemoList
        case addMemo(Memo)
        case deleteMemo(Memo)
        case editMemo(Memo)
        case likeMemo(Memo)
    }
    
    enum Output {
        case showAddMemoViewController
        case showEditMemoViewController(Memo)
        case fetchMemoListSuccess([Memo])
        case fetchMemoListFailed(Error)
        case addMemoSuccess
        case addMemoFailed(Error)
        case deleteMemoSuccess
        case deleteMemoFailed(Error)
        case editMemoSuccess
        case editMemoFailed(Error)
        case likeMemoSuccess
        case likeMemoFailed(Error)
    }
    
    private var useCase: MemoUseCaseProtocol
    private let output: PassthroughSubject<Output, Never> = .init()
    
    @Published var memoList: [Memo] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: MemoUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> { // VC 이벤트 -> VM 데이터
        input.sink { [weak self] input in
            guard let self else { return }
            switch input {
            case .addMemoButtonTapped:
                output.send(.showAddMemoViewController)
            case .editMemoCellTapped(let memo) :
                output.send(.showEditMemoViewController(memo))
            case .viewWillAppear, .fetchMemoList:
                switch useCase.fetchMemos() {
                case .success(let memoList):
                    self.memoList = memoList
                    output.send(.fetchMemoListSuccess(memoList))
                case .failure(let error):
                    output.send(.fetchMemoListFailed(error))
                }
            case .addMemo(let newMemo):
                switch useCase.addMemo(title: newMemo.title, content: newMemo.content ?? "") {
                case .success(_):
                    self.addMemo(newMemo)
                    output.send(.addMemoSuccess)
                case .failure(let error):
                    output.send(.addMemoFailed(error))
                }
            case .deleteMemo(let memo):
                switch useCase.deleteMemo(memo: memo) {
                case .success(_):
                    output.send(.deleteMemoSuccess)
                case .failure(let error):
                    output.send(.deleteMemoFailed(error))
                }
            case .editMemo(let memo):
                switch useCase.editMemo(memo: memo) {
                case .success(_):
                    self.updateMemo(memo)
                    output.send(.editMemoSuccess)
                case .failure(let error):
                    output.send(.editMemoFailed(error))
                }
            case .likeMemo(let memo):
                switch useCase.toggleLike(newStateMemo: memo) {
                case .success(_):
                    self.toggleLike(memo)
                    output.send(.likeMemoSuccess)
                case .failure(let error):
                    output.send(.likeMemoFailed(error))
                }
            }
        }
        .store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func addMemo(_ newMemo: Memo) {
        memoList.insert(newMemo, at: 0)
    }
    
    func deleteMemo(_ memo: Memo) {
        if let index = memoList.firstIndex(where: { $0.id == memo.id }) {
            memoList.remove(at: index)
        }
    }
    
    func updateMemo(_ memo: Memo) {
        if let index = memoList.firstIndex(where: { $0.id == memo.id }) {
            memoList[index] = memo
        }
    }
    
    func toggleLike(_ memo: Memo) {
        if let index = memoList.firstIndex(where: { $0.id == memo.id }) {
            let _ = memoList[index].toggleLike()
        }
    }
    
    
}
