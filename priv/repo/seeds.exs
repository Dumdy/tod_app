# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
alias Todo.{Accounts, Repo}
alias Todo.Accounts.{User, TodoActivity}
User |> Repo.delete_all()

{:ok, janny} =
  Accounts.create_user(%{
    user_name: "Janny",
    email: "janny@email.com"
  })

TodoActivity |> Repo.delete_all()
Accounts.create_todo_activity(%{activity: "Do some dirty dishes", user_id: janny.id})
