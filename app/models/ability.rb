class Ability
  include CanCan::Ability

  def initialize(user)
    @all_roles = [:super_admin, :admin, :teacher, :student]

    if @all_roles.include?(user.user_role)
      @ind = @all_roles.find_index(user.user_role)
      @edit_able_roles = @all_roles.slice(@ind, @all_roles.length)
      @users_id = []
      SuperAdmin.all().each do |user_|
        if @edit_able_roles.include?(user_.user_role)
          @users_id << user_.id
        end
      end
      can :read, SuperAdmin, :id => @users_id
      can :update, SuperAdmin, :id => @users_id
    end
  end
end
