class User < ApplicationRecord

    attr_reader :password

    validates :username, :password_digest, :session_token, presence: true
    validates :password, length: {minimum: 5}
    validates :username, :session_token, uniqueness: true

    after_initialize :ensure_session_token

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)    
        if user.nil?
            nil
        else
            user.is_password?(password) ? user : nil
        end
    end

    def ensure_session_token
        self.session_token ||= generate_session_token
    end

    def generate_session_token
        SecureRandom.urlsafe_base64(16)
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        return self.session_token
    end

    def password=(new_pw)
        @password = new_pw
        self.password_digest = BCrypt::Password.create(new_pw)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end
end