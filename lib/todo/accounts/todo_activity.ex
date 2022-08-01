defmodule Todo.Accounts.TodoActivity do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todo.Accounts.User

  schema "todo_activities" do
    field :activity, :string
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(todo_activity, attrs) do
    todo_activity
    |> cast(attrs, [:user_id, :activity])
    |> validate_required([:user_id, :activity])
    |> assoc_constraint(:user)
  end
end
