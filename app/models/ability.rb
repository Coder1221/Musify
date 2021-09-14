class Ability
  include CanCan::Ability

  def initialize(user)
    # all_roles = [:SuperAdmin ,:admin , :teacher , :student]
    # if all_roles.include?(user.user_role)
    #   ind = all_roles.find_index(all_roles)
    #   edit_able_roles  = all_roles(ind ,all_roles.length)
    #   users  = SuperAdmin.all()
    #   users_id = []
    #   users.each do |user|
    #     if edit_able_roles.include?(user.user_role)
    #       users_id << user.id
    #     end 
    #   end
    #   can :edit , SuperAdmin , :id  => users_id
    # end 
  end
end
