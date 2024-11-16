# Babotie

A fun little free gambling website built with Elixir, TypeScript, SvelteKit and Phoenix.
The website is built with the idea of being a fun and free gambling website for users to play games and chat with each other.
There will be no real money involved. The only form of monetization will be 5 daily ads that users can watch to earn chips.

## Layout of Website

```D
/ - redirects to dashboard or login page
/login - Login page
/register - Register new users page (Button on login page)
/login/forgot-password - Forgot password page
/login/reset-password/[reset-token] - Reset password email page
/logout - Logout (Button in user menu)
/dashboard - Homepage for users logged in
/(games)/[game] - Game pages with game rules, different variants and tables.
/(games)/[game]/[table]/ - Table pages (For example /roulette/table-1)
/(games)/[game]/[table]/[variant] - Games with different variants (For example /poker/table-1/texas-holdem)
/profile/[user-id] - User profile page
/profile/[user-id]/friends - User friends list (Add friends, Remove friends, etc.)
/profile/[user-id]/edit - User settings page (Change password or email, Message settings, Friend Settings, etc.)
/leaderboard - Leaderboard homepage
/leaderboard/tokens - Leaderboard for tokens
/leaderboard/[game] - Player leaderboards for each game
/leaderboard/[game]/[variant] - Games with different variants (For example /poker/texas-holdem)
/history - Game history page
/settings - Settings page
/customer-support - Customer support page
/tokens/daily/spin - Daily spin page
/tokens/daily/login - Daily login bonus page
/tokens/daily/ad-bonus/ - Daily ads page (Max of 5 ads per day)
/messages - Send direct messages (Players can configure who can send them messages in their settings)
```

## TODO

- [ ] Implement Roulette
- [ ] Implement Blackjack
- [ ] Implement Slots
- [ ] Implement Poker (Maybe different versions of poker like Texas Hold'em, 3 Card Poker, Caribbean Stud Poker, etc.?)
- [ ] Leaderboards for all games
- [ ] User Authentication
- [ ] User Profiles
- [ ] Daily Login Chips (Based on user level and login streak)
- [ ] Daily Spin for Chips (Rewards for 7/30/90 days spun in a row?)
- [ ] Notice Board Dashboard
- [ ] Notifications (For example, when someone sends you a message, or when your table is ready)
- [ ] Settings
- [ ] Email Verification
- [ ] Tables for each game
- [ ] Game History
- [ ] Daily Ads for Chips (Limited to 5 ads per day)
- [ ] Suggestions Board
- [ ] Real-time game updates (For example, when someone wins the jackpot on slots, it updates for everyone in the lobby)
- [ ] History of all players
- [ ] Player limits per table (For example some tables can only have 4 players, and some can have 8)
- [ ] Bet limits per table (For example some tables can only have bets between 1 token and 100 tokens, and some can have bets between 100 tokens and 1000 tokens)
- [ ] User menu with notifications, messages, settings, logout, profile, etc.
- [ ] Direct Messages
- [ ] Notifications
- [ ] Customer Support options with live chat and email
- [ ] Lobby chat
- [ ] Game chat
- [ ] Game chat history
- [ ] Suggestions board
- [ ] Notice board dashboard

## DB Schemas

Uses Ecto for database queries.

```elixir
    schema "user" do
        field :email, :string, null: false
        field :username, :string, null: false
        field :password, :string, redact: true, null: false
        field :tokens, :integer, default: 0
        field :last_login, :utc_datetime
        field :last_logout, :utc_datetime
        field :last_activity, :utc_datetime
        field :status, Ecto.Enum, values: [:online, :offline]
        field :is_admin, :boolean, default: false
        field :is_banned, :boolean, default: false
        field :banned_until, :utc_datetime
        field :banned_reason, :string
        field :friend_ids, {:array, :integer}, default: []
        field :blocked_user_ids, {:array, :integer}, default: []
        field :messages, {:array, :map}, default: []
        field :notifications, {:array, :map}, default: []
        field :settings, :map, default: %{}
        field :last_spin, :utc_datetime
        field :history, {:array, :map}, default: []
        field :daily_ads_watched, :integer, default: 0
        field :days_logged_in, :integer, default: 0
        field :level, :integer, default: 1
        field :experience, :integer, default: 0
        field :biggest_win, :integer, default: 0
        field :login_streak, :integer, default: 0
        field :daily_spin_streak, :integer, default: 0
        field :claimed_daily_spin, :boolean, default: false
        field :claimed_daily_login, :boolean, default: false
        timestamps()
    end

    schema "game" do
        field :name, :string
        field :description, :string
        field :rules, :string
        field :variants, {:array, :map}, default: []
        field :table_ids, {:array, :integer}, default: []
        timestamps()
    end

    schema "table" do
        field :game_id, :integer
        field :name, :string
        field :variant, :string
        field :players, {:array, :map}, default: []
        field :bet_limits, {:array, :map}, default: []
        field :player_limits, {:array, :map}, default: []
        field :status, Ecto.Enum, values: [:open, :closed], default: :open
        field :chat_history, {:array, :map}, default: []
        field :game_history, {:array, :map}, default: []
        timestamps()
    end

    schema "token_log" do
        field :user_id, :integer
        field :tokens, :integer
        field :reason, :string
        timestamps()
    end

    schema "message" do
        field :sender_id, :integer
        field :receiver_id, :integer
        field :message, :string
        field :is_read, :boolean, default: false
        timestamps()
    end

    schema "notification" do
        field :user_id, :integer
        field :notification, :string
        field :is_read, :boolean, default: false
        timestamps()
    end

    schema "suggestion" do
        field :suggestion, :string
        field :is_approved, :boolean, default: false
        timestamps()
    end

    schema "roulette_log" do
        field :user_id, :integer
        field :roulette_id, :integer
        field :bet, :integer
        field :win, :boolean
        field :result, :string
        timestamps()
    end

    schema "blackjack_log" do
        field :user_id, :integer
        field :blackjack_id, :integer
        field :bet, :integer
        field :win, :boolean
        field :result, :string
        timestamps()
    end

    schema "slots_log" do
        field :user_id, :integer
        field :slots_id, :integer
        field :bet, :integer
        field :win, :boolean
        field :result, :string
        timestamps()
    end

    schema "poker_log" do
        field :user_id, :integer
        field :poker_id, :integer
        field :bet, :integer
        field :win, :boolean
        field :result, :string
        timestamps()
    end

    schema "daily_spin_log" do
        field :user_id, :integer
        field :result, :string
        timestamps()
    end

    schema "customer_support_log" do
        field :user_id, :integer
        field :message, :string
        field :is_resolved, :boolean, default: false
        timestamps()
    end
```
