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
}

final class MemoViewModel: ObservableObject, MemoViewModelProtocol {
    
    enum Input {
        case viewWillAppear
        case fetchMemoList
        case addMemo(Memo)
        case deleteMemo(Memo)
        case eidtMemo(Memo)
        case likeMemo(Memo)
    }
    
    enum Output {
        case fetchMemoListSuccess([Memo])
        case fetchMemoListFailed(Error)
        case addMemoSuccess
        case addMemoFailed(Error)
        case deleteMemoSuccess
        case deleteMemoFailed(Error)
        case eidtMemoSuccess
        case eidtMemoFailed(Error)
        case likeMemoSuccess
        case likeMemoFailed(Error)
    }
    
    private var useCase: MemoUseCaseProtocol
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var memos: [Memo] = []
    
    init(useCase: MemoUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> { // VC 이벤트 -> VM 데이터
        input.sink { [weak self] input in
            guard let self else { return }
            switch input {
            case .viewWillAppear, .fetchMemoList:
                switch useCase.fetchMemos() {
                case .success(let memos):
                    output.send(.fetchMemoListSuccess(memos))
                case .failure(let error):
                    output.send(.fetchMemoListFailed(error))
                }
            case .addMemo(let memo):
                switch useCase.addMemo(title: memo.title, content: memo.content ?? "") {
                case .success(_):
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
            case .eidtMemo(let memo):
                switch useCase.editMemo(memo: memo) {
                case .success(_):
                    output.send(.eidtMemoSuccess)
                case .failure(let error):
                    output.send(.eidtMemoFailed(error))
                }
            case .likeMemo(let memo):
                switch useCase.toggleLike(memo: memo) {
                case .success(_):
                    output.send(.likeMemoSuccess)
                case .failure(let error):
                    output.send(.likeMemoFailed(error))
                }
            }
        }
        .store(in: &cancellables)
        return output.eraseToAnyPublisher()
        
    }
    
}
