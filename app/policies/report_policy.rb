class ReportPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || (user.id == record.user_id)
  end

  def create?
    true
  end
  
  def update?
    user.admin? || (user.id == record.user_id)
  end

  def destroy?
    user.admin?
  end

  relation_scope do |relation|
    next relation if user.admin?
    relation.where(user: user)
  end
end
