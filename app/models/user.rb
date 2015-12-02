class User < ActiveRecord::Base
	has_many :sentences, dependent: :destroy
	has_many :vocabs, dependent: :destroy
	has_many :words, :through => :vocabs
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation

	email_regex = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	validates :name, :presence   => true,
			  :length		     => { :maximum => 50 } 
	validates :email, :presence  => true,
			  :format 			 => { :with => email_regex },
			  :uniqueness 		 => { :case_sensitive => false }

	validates :password, :presence => true,
			  :confirmation => true

	before_save :encrypt_password

	def has_password?(submitted_password)
		self.encrypted_password = encrypt(submitted_password)
	end

	def self.authenticate(email, submitted_password)
		user = find_by_email(email)

		return nil if user.nil?
		return user if user.has_password(submitted_password)
	end

	private 
		def encrypt_password
			self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{password}") if self.new_record?
			self.encrypted_password = encrypt(pawwrod)
		end

		def encrypt(pass)
			Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
		end

end
