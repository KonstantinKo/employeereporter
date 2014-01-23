class ReportsController < InheritedResources::Base
  actions :new, :create

  before_filter :authenticate_user!
  before_filter :add_user_association, only: :create

  private
    def add_user_association
      build_resource.user = current_user
    end

    def permitted_params
      params.permit report: [ :question1, :question2, :question3, :question4 ]
    end
end
