defmodule TodoWeb.Schema do
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  import_types(TodoWeb.Types)
  alias Todo.Accounts

  query do
    import_fields(:users_queries)
  end

  mutation do
    import_fields(:users_mutations)
    import_fields(:todo_activities_mutation)
  end

  object :mutation_error do
    field(:key, non_null(:string))
    field(:message, non_null(:string))
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
