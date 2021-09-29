class Ability
  include CanCan::Ability

  def initialize(user)
    if [:super_admin, :admin, :teacher].include?(user.user_role)
      can :manage, School, id: user.school_id.to_i
      can :manage, Lecture
      can :manage, LectureContent
    end

    if user.user_role == :super_admin
      can :manage,
          SuperAdmin,
          id:
            SuperAdmin.with_roles([:admin, :teacher, :student]).where(school_id: user.school_id).pluck(:id) + [user.id]
      can :activate_or_deactivate, SuperAdmin, id: SuperAdmin.with_roles([:admin, :teacher, :student]).pluck(:id)
    end

    if user.user_role == :admin
      can :manage, SuperAdmin, school_id: user.school_id.to_i
      can :manage,
          SuperAdmin,
          id: SuperAdmin.with_roles([:teacher, :student]).where(school_id: user.school_id).pluck(:id) + [user.id]
      can :activate_or_deactivate, SuperAdmin, id: SuperAdmin.with_roles([:teacher, :student]).pluck(:id)
    end

    if user.user_role == :teacher
      can :read, SuperAdmin, school_id: user.school_id.to_i
      @school_students_ids = SuperAdmin.with_roles(:student).where(school_id: user.school_id).pluck(:id)
      can :manage, SuperAdmin, id: @school_students_ids + [user.id]
      can :activate_or_deactivate, SuperAdmin, id: @school_students_ids
    end

    if user.user_role == :student
      can :read, SuperAdmin, id: SuperAdmin.with_roles(:teacher).where(school_id: user.school_id).pluck(:id) + [user.id]
      can :manage, SuperAdmin, id: user.id
      can :read, School, id: user.school_id.to_i
      can :edit, School, id: user.school_id.to_i
      can :read, Lecture
      can :read, LectureContent
    end

    # !This will apply to all -> if we do this in start these will be overridden by manage
    cannot :destroy, SuperAdmin, id: user.id
  end
end
