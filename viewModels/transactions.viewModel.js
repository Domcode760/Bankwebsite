export function transactionsViewModel(data = {}) {
    return {
        bankAccounts: [],
        transactions: [],
        selectedAccount: null,
        ...data
    }
}