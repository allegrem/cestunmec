require 'digest/sha2'

class Membre < ActiveRecord::Base
  has_many :vannes, :dependent => :destroy
  has_many :lols, :dependent => :destroy
  
  
  validates_presence_of :pseudo, :message => "Alors comme ça tu n'as pas de nom ?"
  validates_uniqueness_of :pseudo, :message => "C'est dur a admettre, mais tu n'es pas le seul sur Terre a posseder ce pseudo ..."
  validates_length_of :pseudo, :in => 2..30, :message => "Ton pseudo est soit trop court, soit trop long. A toi de voir ..."
  
  validates_presence_of :email, :message => "Mais comment fais-tu pour vivre sans email ??"
  validates_uniqueness_of :email, :message => "Je crois qu'on a pique ton email pour creer un autre compte ..."
  validates_format_of :email, :with => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, :message => "Le truc que tu m'as poste ne ressemble pas a un email. Enfin je crois pas ..."
  
  validates_confirmation_of :passwd, :message => "Soit je lis tres mal, soit les deux mots de passe que tu as entre sont differents ... Essaie encore !"
  validates_length_of :passwd, :minimum => 4, :message => "Tu crois vraiment avoir un mot de passe sûr avec moins de 4 caracteres ??"
  attr_accessor :passwd_confirmation
  attr_reader :passwd
  validate :passwd_must_be_present
  
  
  before_destroy :decrease_lols_count
  
  
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
    errors.add(:passwd, "Un mot de passe vide n'est pas un bon mot de passe !") unless hashed_passwd.present?
  end
  
  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def decrease_lols_count
    self.lols.each do |l|
      Vanne.decrement_counter(:lols_count, v.id)
    end
  end
end
