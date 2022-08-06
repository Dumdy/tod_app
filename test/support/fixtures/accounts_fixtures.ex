defmodule Todo.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todo.Accounts` context.
  """

  @doc """
  Generate a user.
  """

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "janny@email.com",
        user_name: "Janny"
      })
      |> Todo.Accounts.create_user()

    user
  end

  @doc """
  Generate a todo_activity.
  """
  def todo_activity_fixture(attrs \\ %{}) do
    user = user_fixture()

    {:ok, todo_activity} =
      attrs
      |> Enum.into(%{
        activity: "Do some dirty dishes",
        user_id: user.id
      })
      |> Todo.Accounts.create_todo_activity()

    todo_activity
  end
end
