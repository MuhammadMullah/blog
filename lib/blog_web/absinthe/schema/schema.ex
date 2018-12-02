defmodule BlogWeb.Absinthe.Schema do
  use Absinthe.Schema
  import_types(BlogWeb.Absinthe.Schema.Types)

  query do
    field :posts, list_of(:post) do
      resolve(&Blog.Blog.PostResolver.all/2)
    end

    field :user_posts, list_of(:post) do
      middleware(BlogWeb.Middleware.Authorize)
      resolve(&Blog.Blog.PostResolver.user_all/2)
    end

    field :post, type: :post do
      arg(:id, non_null(:id))
      middleware(BlogWeb.Middleware.Authorize)
      resolve(&Blog.Blog.PostResolver.find/2)
    end

    # user query
    field :login, type: :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Blog.Account.UserResolver.login/2)
    end

    mutation do
      field :create_post, type: :post do
        arg(:title, non_null(:string))
        arg(:body, non_null(:string))
        arg(:tags, non_null(:string))

        resolve(&Blog.Blog.PostResolver.create/2)
      end

      field :update_post, type: :post do
        arg(:id, non_null(:id))
        arg(:post, :update_post_params)

        resolve(&Blog.Blog.PostResolver.update/2)
      end

      field :delete_post, type: :post do
        arg(:id, non_null(:id))
        resolve(&Blog.Blog.PostResolver.delete/2)
      end

      # users fields
      # TODO: will return token later
      field :create_user, type: :user do
        arg(:username, non_null(:string))
        arg(:email, non_null(:string))
        arg(:password, non_null(:string))

        resolve(&Blog.Account.UserResolver.create/2)
      end
    end
  end
end
