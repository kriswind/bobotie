import { redirect } from "@sveltejs/kit";

// Redirect user to /login no authentication yet
export const load = async () => {
    redirect(302, "/login");
};