# frozen_string_literal: true

class GroupsService
  def generate
    new_groups = generate_groups
    new_group_leaders = generate_group_lieders_for(new_groups)

    create_groups_and_invitations_for(new_groups, new_group_leaders)
  end

  private

  def create_groups_and_invitations_for(new_groups, new_group_leaders)
    new_group_leaders.each_with_index do |lieder, index|
      new_group = Group.create!(
        week: this_week
      )

      new_groups[index].each do |employee|
        GroupInvitation.create!(
          group: new_group,
          user: employee,
          leader: lieder == employee
        )
      end
    end
  end

  def generate_group_lieders_for(new_groups)
    new_groups.map do |group|
      no_leader_group = group.reject { |employee| last_week_leaders.include?(employee) }

      return group.sample if no_leader_group.blank?

      no_leader_group.sample
    end
  end

  def generate_groups
    groups = initalize_empty_groups
    position = 0

    shuffled_departaments.each do |departament|
      shuffled_employees = shuffled_employees_for(departament)

      shuffled_employees.each do |employee|
        group = groups[position % groups_amount]

        group.push(employee)

        position += 1
      end
    end

    groups
  end

  def initalize_empty_groups
    Array.new(groups_amount) { [] }
  end

  def groups_amount
    @groups_amount ||= (employee_count.to_f / max_group_size).ceil
  end

  def shuffled_employees_for(departament)
    departament.users.shuffle
  end

  def shuffled_departaments
    Department.includes(:users).shuffle
  end

  def last_week_leaders
    @last_week_leaders ||= last_week.present? ? Group.includes(:leader).where(week: last_week).map(&:leader) : []
  end

  def this_week
    @this_week ||= Group.calculate_this_week_number
  end

  def last_week
    Group.last.try(:week)
  end

  def employee_count
    @employee_count ||= User.count
  end

  def max_group_size
    ENV.fetch('MAX_GROUP_SIZE', 4).to_i
  end
end
