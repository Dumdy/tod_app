defmodule TodoWeb.Types do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers
  import TodoWeb.ChangesetErrors
  alias Todo.Accounts

  object :users_type do
    field :id, :id
    field :user_name, :string
    field :email, :string

    field :todo_activities, list_of(:todo_activities_type),
      resolve: dataloader(Accounts, :todo_activities)
  end

  object :todo_activities_type do
    field :id, :id
    field :activity, :string
  end

  input_object :users_input_type do
    field :user_name, non_null(:string)
    field :email, non_null(:string)
  end

  input_object :todo_activities_input_type do
    field :actiivity, non_null(:string)
    field :user_id, non_null(:id)
  end

  object :users_queries do
    field :users, list_of(:users_type) do
      resolve(fn _, _ ->
        {:ok, Accounts.list_users()}
      end)
    end

    field :todo_activities, list_of(:todo_activities_type) do
      resolve(fn _, _ ->
        {:ok, Accounts.list_todo_activities()}
      end)
    end
  end

  object :users_mutations do
    field :create_user, :users_type, description: "Create a new user" do
      arg(:input, non_null(:users_input_type))

      resolve(fn %{input: input}, _ ->
        case Accounts.create_user(input) do
          {:error, changeset} ->
            {:error, transform_errors(changeset)}

          {:ok, user} ->
            {:ok, user}
        end
      end)
    end

    field :create_todo_activity, :todo_activities_type, description: "Create a new todo activity" do
      arg(:input, non_null(:todo_activities_input_type))

      resolve(fn %{input: input}, _ ->
        case Accounts.create_todo_activity(input) do
          {:error, changeset} ->
            {:error, transform_errors(changeset)}

          {:ok, todo_activity} ->
            {:ok, todo_activity}
        end
      end)
    end
  end
end
