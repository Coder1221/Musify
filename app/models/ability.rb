class Ability
  include CanCan::Ability

  def initialize(user)
    @all_roles = [:admin, :teacher, :student]
    if user.user_role == :super_admin
      can :manage, SuperAdmin
      can :manage, School, :id => user.school_id.to_i
    end

    if @all_roles.include?(user.user_role) && user.user_role != :student
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
      can :destroy, SuperAdmin, :id => @users_id
      # user cannnot delete himself
      cannot :destroy, SuperAdmin, :id => user.id
      can :activate_or_deactivate, SuperAdmin, :id => @users_id
      cannot :activate_or_deactivate, SuperAdmin, :id => user.id
      can :manage, School, :id => user.school_id.to_i
    end

    if user.user_role == :student
      can :read, SuperAdmin, :id => user.id
      can :update, SuperAdmin, :id => user.id
      can :read, School, :id => user.school_id.to_i
    end
  end
end
