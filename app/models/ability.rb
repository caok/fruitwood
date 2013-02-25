class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    @user ? user_rules : guest_rules
  end

  def user_rules
    @user.roles.each { |role| send("#{role}_rules") }
    default_rules
  end

  def admin_rules
    can :manage, :all
  end

  def customer_rules
    can :read, :all
    can :create, Comment
    can :destroy, Comment do |c|
      c.user_id == @user.id
    end
  end

  def guest_rules
  end

  def default_rules
  end
end
