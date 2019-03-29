class Response < ApplicationRecord
    validates :user_id, :answer_choice_id, presence:true
    # validate :one_answer_per_respondent
    # validate :always_error
    validate :respondent_already_answered?

    belongs_to :answer_choice,
        primary_key: :id,
        foreign_key: :answer_choice_id,
        class_name: :AnswerChoice 

    belongs_to :respondent,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    has_one :question,
        through: :answer_choice,
        source: :question

    # has_many :sibling_responses,
    #     # Proc.new { where("user_id != ?", self.user_id) },
    #     through: :question,
    #     source: :responses

    def sibling_responses
        Response.joins(:question =>:responses).where(id: self.id)
        .select("responses_questions.*")
        # .where("responses_questions.user_id != ?", self.user_id)
    end

    def respondent_already_answered?
        siblings = sibling_responses 
        if siblings.pluck(:user_id).include?(self.user_id)
            errors[:base] << 'Each respondent can only answer once'
        end
    end

    def one_answer_per_respondent
        if respondent_already_answered?
            errors[:base] << 'Each respondent can only answer once'
        end
    end

    def no_author_may_respond
        if self.question.poll.user_id == self.user_id
            errors[:base] << "You done fucked up"
        end
    end

    def always_error
        errors[:user_id] << 'hmmm'
    end

end
