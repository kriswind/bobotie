import { fail, type Actions } from "@sveltejs/kit";


export const actions: Actions = {
    default: async ({ request }) => {
        const formData = await request.formData();

        const username = formData.get('username')?.toString();
        const password = formData.get('password')?.toString();

        if (!username || !password) {
            return fail(400, { errorMessage: 'All fields are required.' });
        }

        try {
            const response = await fetch('http://localhost:4000/api/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
            });
        

            if (!response.ok) {
                const data = await response.json();
                return fail(400, { errorMessage: data.error || 'Login failed.' });
            }

            return { success: true, redirect: '/dashboard' };
        } catch (error) {
            return fail(500, { errorMessage: 'Server error. Please try again later.' });
        }
    }
}