import { fail, type Actions } from '@sveltejs/kit';

export const actions: Actions = {
    default: async ({ request }) => {
        const formData = await request.formData();

        const email = formData.get('email')?.toString();
        const username = formData.get('username')?.toString();
        const password = formData.get('password')?.toString();

        // Validate the form data
        if (!email || !username || !password) {
            return fail(400, { errorMessage: 'All fields are required.' });
        }

        try {
            const response = await fetch('http://localhost:4000/api/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ email, username, password }),
            });

            if (!response.ok) {
                const data = await response.json();
                return fail(400, { errorMessage: data.error || 'Registration failed.' });
            }

            return { success: true, redirect: '/login' };
        } catch (error) {
            return fail(500, { errorMessage: 'Server error. Please try again later.' });
        }
    },
};
