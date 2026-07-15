export function loginViewModel(data = {}) {
    return {
            username: "",
        ...data
    }
}