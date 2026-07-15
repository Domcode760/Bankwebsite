export function transferViewModel(data = {}) {
    return {
        bankAccounts: [],
        selectedAccount: null,
        ...data
    }
}