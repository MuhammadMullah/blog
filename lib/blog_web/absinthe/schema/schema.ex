defmodule BlogWeb.Absinthe.Schema do
  use Absinthe.Schema

  require Logger

  import_types(Absinthe.Type.Custom)
  import_types(BlogWeb.Absinthe.Schema.Types)

  alias Blog.{Blog, Account}


  query do
    Logger.info("Magic mike")
    field :user, type: :user do
      middleware(BlogWeb.Middleware.Authorize)
      resolve(&Account.UserResolver.view/2)
    end

    field :posts, list_of(:post) do
      @desc "List user posts"
      arg(:offset, :integer, default_value: 0)

      middleware(BlogWeb.Middleware.Authorize)
      resolve(&Blog.PostResolver.user_all/2)
    end

    field :all_posts, list_of(:post) do
      @desc "List all post from users"
      arg(:offset, :integer, default_value: 0)

      resolve(&Blog.PostResolver.all/2)
    end

    field :post, type: :post do
      @desc "List single post"
      arg(:id, non_null(:id))
      middleware(BlogWeb.Middleware.Authorize)
      resolve(&Blog.PostResolver.find/2)
    end

    # user query
    field :login, type: :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Account.UserResolver.login/2)
    end

    mutation do
      field :create_post, type: :post do
        arg(:title, non_null(:string))
        arg(:body, non_null(:string))
        arg(:tags, non_null(:string))

        resolve(&Blog.PostResolver.create/2)
      end

      field :update_post, type: :post do
        arg(:id, non_null(:id))
        arg(:post, :update_post_params)

        resolve(&Blog.PostResolver.update/2)
      end

      field :delete_post, type: :post do
        arg(:id, non_null(:id))
        resolve(&Blog.PostResolver.delete/2)
      end

      # users fields
      # TODO: will return token later
      field :create_user, type: :user do
        arg(:username, non_null(:string))
        arg(:email, non_null(:string))
        arg(:password, non_null(:string))

        resolve(&Account.UserResolver.create/2)
      end
    end
  end
end
