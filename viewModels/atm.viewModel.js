export function atmViewModel(data ={}) {
    return {
        bankAccounts: [],
        selectedId: 0,
        type: null,
        ...data
    }
}

