<script>
    let username = $state("");
    let password = $state("");

</script>

<form method="post">
    <input type="text" bind:value={username} placeholder="Username" />
    <input type="password" bind:value={password} placeholder="Password" />
    <button type="submit">Login</button>
    <a href="/register">Register</a>
</form>
