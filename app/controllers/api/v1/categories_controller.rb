module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        @categories = Category.all
        if @categories
          render json: { success: true, errors: {}, result: { categories: serialize_resource(@categories) } }
        else
          render json: { success: false, errors: @categories.errors.messages, result: {} }
        end
      end
    end
  end
end
