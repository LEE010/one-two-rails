class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :management, :toggle, :my_profile, :like, :unlike, :thumb_up, :thumb_down, to: :update
    alias_action :search, :main, :kakao, :kakao_success, :result, to: :read
    # Define abilities for the passed in user here. For example:
    #
      # user ||= User.new # guest user (not logged in)
      
      if user.has_role? :admin
        can :manage, :all
      elsif user.has_role? :seller
        can :read, :all
        can [:create, :update], [Profile, Store], user: user
        can :manage, Product, store: user.store
        can :manage, Option, store: user.store
        can :manage, Post, user: user
      else
        can :read, :all
        can [:create, :update], [Profile], user: user
        can [:manage], [Post], user: user
        can [:create], [Store], user: user
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
