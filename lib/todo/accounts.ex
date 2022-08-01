defmodule Todo.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Todo.Repo

  alias Todo.Accounts.{User, TodoActivity}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns the list of todo_activities.

  ## Examples

      iex> list_todo_activities()
      [%TodoActivity{}, ...]

  """
  def list_todo_activities do
    Repo.all(TodoActivity)
  end

  @doc """
  Gets a single todo_activity.

  Raises `Ecto.NoResultsError` if the Todo activity does not exist.

  ## Examples

      iex> get_todo_activity!(123)
      %TodoActivity{}

      iex> get_todo_activity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_todo_activity!(id), do: Repo.get!(TodoActivity, id)

  @doc """
  Creates a todo_activity.

  ## Examples

      iex> create_todo_activity(%{field: value})
      {:ok, %TodoActivity{}}

      iex> create_todo_activity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_todo_activity(attrs \\ %{}) do
    %TodoActivity{}
    |> TodoActivity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a todo_activity.

  ## Examples

      iex> update_todo_activity(todo_activity, %{field: new_value})
      {:ok, %TodoActivity{}}

      iex> update_todo_activity(todo_activity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_todo_activity(%TodoActivity{} = todo_activity, attrs) do
    todo_activity
    |> TodoActivity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a todo_activity.

  ## Examples

      iex> delete_todo_activity(todo_activity)
      {:ok, %TodoActivity{}}

      iex> delete_todo_activity(todo_activity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_todo_activity(%TodoActivity{} = todo_activity) do
    Repo.delete(todo_activity)
  end
end
