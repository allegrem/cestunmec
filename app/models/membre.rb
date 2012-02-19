require 'digest/sha2'

class Membre < ActiveRecord::Base
  has_many :vannes
  has_many :lols
  
  validates :pseudo, :presence => true, :uniqueness => true
  
  validates :passwd, :confirmation => true
  attr_accessor :passwd_confirmation
  attr_reader :passwd
  validate :passwd_must_be_present
  
  def Membre.authenticate(pseudo, passwd)
    if membre = find_by_pseudo(pseudo)
      if membre.hashed_passwd == encrypt_passwd(passwd, membre.salt)
	membre
      end
    end
  end
  
  def Membre.encrypt_passwd(passwd, salt)
    Digest::SHA2.hexdigest(passwd + "cestunmec" + salt)
  end
  
  # 'passwd' is a virtual attribute
  def passwd=(passwd)
    @passwd = passwd
    if passwd.present?
      generate_salt
      self.hashed_passwd = self.class.encrypt_passwd(passwd, salt)
    end
  end
  
  def admin?
    self.admin = true
  end
  
  
  private
  def passwd_must_be_present
    errors.add(:passwd, "Missing passwd") unless hashed_passwd.present?
  end
  
  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end
