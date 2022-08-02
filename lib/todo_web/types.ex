defmodule TodoWeb.Types do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers
  import TodoWeb.ChangesetErrors
  alias Todo.{Accounts, Repo}
  alias Todo.Accounts.{User, TodoActivity}

  object :users_type do
    field :id, :id
    field :user_name, :string
    field :email, :string
    field :inserted_at, :datetime
    field :updated_at, :datetime

    field :todo_activities, list_of(:todo_activities_type),
      resolve: dataloader(Accounts, :todo_activities)

    field(:error, list_of(:mutation_error))
  end

  object :todo_activities_type do
    field :id, :id
    field :activity, :string
    field :inserted_at, :datetime
    field :updated_at, :datetime
    field(:error, list_of(:mutation_error))
  end

  input_object :users_input_type do
    field :user_name, non_null(:string)
    field :email, non_null(:string)
  end

  input_object :todo_activities_input_type do
    field :activity, non_null(:string)
    field :user_id, non_null(:id)
  end

  input_object :todo_activities_update_input_type do
    field :activity, non_null(:string)
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
    field :create_user, :users_type, description: "Create a new user, using the mutation:
          mutation{
            createUser(input: {$userName: String, $email: String}){
              id
              userName
              email
    }
   }
    " do
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

    field :update_user, :users_type, description: "Update a user's info, using the mutation:
          mutation{
            updateUser($userId: String, input: {$userName: sttring, $email: String}){
              id
              email
              userName

            }
        }
" do
      arg(:user_id, non_null(:id))
      arg(:input, non_null(:users_input_type))

      resolve(fn %{input: params} = args, _ ->
        user = User |> Repo.get!(args[:user_id])

        case Accounts.update_user(
               user,
               params
             ) do
          {:error, changeset} ->
            {:error, transform_errors(changeset)}

          {:ok, user} ->
            {:ok, user}
        end
      end)
    end

    field :delete_user, :users_type, description: "Delete a user's info with the mutation:
    mutation{
      deleteUser($userId: String){
        userName
        email
      }
    }
    " do
      arg(:user_id, non_null(:id))

      resolve(fn args, _ ->
        user =
          User
          |> Repo.get!(args[:user_id])

        case Accounts.delete_user(user) do
          {:error, changeset} ->
            {:error, transform_errors(changeset)}

          {:ok, user} ->
            {:ok, user}
        end
      end)
    end
  end

  object :todo_activities_mutation do
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

    field :update_todo, :todo_activities_type,
      description: "Update a todo activity, using the mutation:
          mutation{
            updateTodo($todoActivityId: String, input: {$todoActivity: String}){
              id
              email
              userName

            }
        }
" do
      arg(:todo_activity_id, non_null(:id))
      arg(:input, non_null(:todo_activities_update_input_type))

      resolve(fn %{input: params} = args, _ ->
        todo_activity = TodoActivity |> Repo.get!(args[:todo_activity_id])

        case Accounts.update_todo_activity(
               todo_activity,
               params
             ) do
          {:error, changeset} ->
            {:error, transform_errors(changeset)}

          {:ok, todo_activity} ->
            {:ok, todo_activity}
        end
      end)
    end

    field :delete_todo, :todo_activities_type,
      description: "Delete a user's todo with the mutation:
    mutation{
      deleteUser($todoActivityId: String){
        userName
        email
      }
    }
    " do
      arg(:todo_activity_id, non_null(:id))

      resolve(fn args, _ ->
        todo_activity =
          TodoActivity
          |> Repo.get!(args[:todo_activity_id])

        case Accounts.delete_todo_activity(todo_activity) do
          {:error, changeset} ->
            {:error, transform_errors(changeset)}

          {:ok, todo_activity} ->
            {:ok, todo_activity}
        end
      end)
    end
  end
end
