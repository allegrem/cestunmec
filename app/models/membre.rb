require 'digest/sha2'

class Membre < ActiveRecord::Base
  has_many :vannes, :dependent => :destroy
  has_many :lols, :dependent => :destroy
  
  
  validates :pseudo, :presence => true, :uniqueness => true, :length => { :in => 2..30 }
  
  validates :email, :presence => true, :uniqueness => true, :format => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/
  
  validates :passwd, :confirmation => true, :length => { :minimum => 4 }
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
    !(self.admin == false  ||  self.admin == nil  ||  self.admin == 'f')
  end
  
  
  private
  def passwd_must_be_present
    errors.add(:passwd, "Missing passwd") unless hashed_passwd.present?
  end
  
  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end
