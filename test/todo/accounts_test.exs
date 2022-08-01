defmodule Todo.AccountsTest do
  use Todo.DataCase

  alias Todo.{Accounts, Repo}

  describe "users" do
    alias Todo.Accounts.User

    import Todo.AccountsFixtures

    @invalid_attrs %{email: nil, user_name: nil}

    test "list_users/0 returns all users" do
      assert Accounts.list_users() == Repo.all(User)
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", user_name: "some user_name"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.user_name == "some user_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", user_name: "some updated user_name"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.user_name == "some updated user_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end
  end

  describe "todo_activities" do
    alias Todo.Accounts.TodoActivity

    import Todo.AccountsFixtures

    @invalid_attrs %{activity: nil, user_id: nil}

    test "list_todo_activities/0 returns all todo_activities" do
      assert Accounts.list_todo_activities() == Repo.all(TodoActivity)
    end

    test "get_todo_activity!/1 returns the todo_activity with given id" do
      todo_activity = todo_activity_fixture()
      assert Accounts.get_todo_activity!(todo_activity.id) == todo_activity
    end

    test "create_todo_activity/1 with valid data creates a todo_activity" do
      user = user_fixture()
      valid_attrs = %{activity: "some activity", user_id: user.id}

      assert {:ok, %TodoActivity{} = todo_activity} = Accounts.create_todo_activity(valid_attrs)
      assert todo_activity.activity == "some activity"
      assert todo_activity.user_id == user.id
    end

    test "create_todo_activity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_todo_activity(@invalid_attrs)
    end

    test "update_todo_activity/2 with valid data updates the todo_activity" do
      todo_activity = todo_activity_fixture()
      update_attrs = %{activity: "some updated activity"}

      assert {:ok, %TodoActivity{} = todo_activity} =
               Accounts.update_todo_activity(todo_activity, update_attrs)

      assert todo_activity.activity == "some updated activity"
    end

    test "update_todo_activity/2 with invalid data returns error changeset" do
      todo_activity = todo_activity_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_todo_activity(todo_activity, @invalid_attrs)

      assert todo_activity == Accounts.get_todo_activity!(todo_activity.id)
    end

    test "delete_todo_activity/1 deletes the todo_activity" do
      todo_activity = todo_activity_fixture()
      assert {:ok, %TodoActivity{}} = Accounts.delete_todo_activity(todo_activity)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_todo_activity!(todo_activity.id) end
    end
  end
end
