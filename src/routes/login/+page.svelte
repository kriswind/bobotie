<script>
    let username = $state("");
    let password = $state("");

    function handleSubmit(event) {
        event.preventDefault();
        console.log(username, password);
    }
</script>

<form onsubmit={handleSubmit}>
    <input type="text" bind:value={username} placeholder="Username" />
    <input type="password" bind:value={password} placeholder="Password" />
    <button type="submit">Login</button>
    <a href="/register">Register</a>
</form>
