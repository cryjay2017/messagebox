class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new  
    
    if user.admin?     # 管理员权限
      can :manage, :all
      can :access, :rails_admin
      can :dashboard, :all
    else
      # 当前用户更改评论
      # Message Update
      can :update, Message do |message|
        message.user_id == user.id
      end
      # Message Update
      can :destroy, Message do |message|
        message.user_id == user.id
      end
      
      can :create, :all
      can :read, :all
      can :search, Message
      can :like, Message
      can :unlike, Message
    end
  end
  
end
