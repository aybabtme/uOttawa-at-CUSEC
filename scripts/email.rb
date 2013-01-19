# encoding: UTF-8
require 'tlsmail'
require 'time'
require 'parseconfig'

#
# Configuration
#

# profs, those commented out have already been contacted
prof_course = {
  "Dan Ionescu" => ["ionescu@site.uottawa.ca", "SEG4145"],
  "Dimitrios Makrakis" => ["dimitris@site.uottawa.ca", "CEG4190"],
  "Gregor v. Bochmann" => ["bochmann@eecs.uottawa.ca", "SEG2106"],
  "Timothy Lethbridge" => ["tcl@eecs.uottawa.ca", "SEG/CEG/ELG2911"],
  "Karelyn Davis" => ["kdavi6@uOttawa.ca", "MAT2377"],
  "Herna Viktor" => ["hlviktor@eecs.uottawa.ca", "CSI2101 and CSI2132"],
  "Ahmed Kharmouch" => ["karmouch@site.uottawa.ca", "ITI1500"],
  "Mountassir M'Hammed" => ["mmountas@uOttawa.ca", "MAT2777"],
  "Joseph Khoury" => ["jkhoury@uottawa.ca", "MAT1748"],
  "Matthew McLennan" => ["mmcle020@uOttawa.ca", "PHI2794"],
  "Christian Gigault" => ["cgigault@uOttawa.ca", "PHY2723"],
  "Liam Peyton" => ["lpeyton@site.uottawa.ca", "SEG4910"],
  "Liam Peyton" => ["lpeyton@uottawa.ca", "SEG4910"],
  "Rafael Falcon" => ["rfalcon@uottawa.ca", "CSI4106"],
  "Emad Gad" => ["egad@eecs.uottawa.ca", "ELG2136"],
  "Claude Théoret" => ["ctheoret@uottawa.ca", "ECO1102"],
  "Omar Badreddin" => ["obadr024@uottawa.ca", "CSI2120"],
  "Omar Badreddin" => ["oobahy@gmail.com", "CSI2120"],
  "Nejib Zaguia" => ["zaguia@site.uottawa.ca", "CSI2501"],
  "Robert Laganière" => ["laganier@eecs.uottawa.ca", "CSI2520"],
  "Fadi Malek" => ["malek@site.uottawa.ca", "CSI2532"],
  "Fadi Malek" => ["FADI.MALEK@forces.gc.ca", "CSI2532"],
  "Mahmoud Zarepour" => ["zarepour@uottawa.ca", "MAT2377"],
  "Philip McIlkenny" => ["mcilkenny@telfer.uOttawa.ca", "ADM1340"],
  "David Delcorde" => ["delcorde@telfer.uOttawa.ca", "ADM2320"],
  "Marcel Turcotte" => ["turcotte@eecs.uottawa.ca", "ITI1121"],
  "Michel Godin" => ["michel.godin@uottawa.ca", "PHY2323"],
  "Najwa Haddad" => ["nhaddad@uottawa.ca", "PSY1102"],
  "Jiying Zhao" => ["jyzhao@eecs.uottawa.ca","SEG3155"],
  "Iluju Kiringa" => ["kiringa@site.uottawa.ca", "CSI3140"],
  "Ivan Stojmenovic" => ["ivan@site.uottawa.ca", "CSI3131"],
  "Abdulmotaleb El Saddik" => ["elsaddik@uottawa.ca", "SEG3125"],
  "Peter Piercy" => ["PIERCY@uottawa.ca", "PHY 1124"],
  "Nevena Francetic" => ["nfrancet@uOttawa.ca", "MAT1348"],
  "Miguel A. Garzón Torres" => ["mgarz042@uottawa.ca", "ITI1521"],
}

email_config = ParseConfig.new('email.conf').params
from = email_config['from_address']
password = email_config['password']

#
# Helpers
#

def get_email_body(from, name, email, course)
  text = <<-eos
From: #{from}
To: #{email}
subject: Reminder: students at CUSEC from Jan 16-19
Date: #{Time.now.rfc2822}

Dear prof #{name},

I would like to thank you for your support to our delegation at CUSEC (Canadian University Software Engineering Conference) this year.  We are bringing a record delegation of 46 students, more than any other university so far, and more than doubling our previous effort.

The purpose of this email is to remind you that the following students will be gone to the conference from January 16 (19h00) until January 19 (~21h00).  The following list contains students from your course #{course}. I do not have a per-course break-down, unfortunately.

* Andréas Kaytar-LeFrançois
* Alexandra Phillips
* Antoine Grondin
* Khaled Alissa
* Dylan Lee
* Yusi Fan
* Arcand Jeffrey
* Stephanie Zeidan
* Bowen Cheng
* Emilie Lavigne
* Allyshia Sewdat
* Lianne Sit
* Maryam Alshehab
* Nicolas Primeau
* Elie Tawil
* Jacqueline Do
* Arash Marzi
* Janac Meenachisundaram
* Yasser Ghamlouch
* Tonga Ozyolcular
* Matthew Graham
* Adrian Ramcharitar
* Samira El-Rayyes
* Mohammed Chamma
* Griff George
* Mohammed Raei
* Lin Chen
* Boury Mbodj
* Samuel El-Hage
* Colette Jourbane
* Jean-Luc Martin
* Jean-Philippe Dubé
* Jesus Zambrano
* Jonathan Smith
* Adnan Khan
* Mark Tamer
* Maxime Paradis
* Trung Do
* Maher Manoubi
* Manuel Belmadani
* Adnan Patel
* Christopher Poirier
* Charles Malo
* Mike Wakim
* Behzad Raesifard
* Carol-Ann Renaud
* Liang Nan Dong

Cheers,

Antoine Grondin
2nd year SEG
Head-Delegate, uOttawa delegation to CUSEC 2013.

> Live long and prosper!
eos
return text
end


#
# Starts here
#

Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', from, password, :login) do |smtp|
  prof_course.each do |name, details|

    to = details[0]
    prof_name = name
    course_code = details[1]

    content = get_email_body(from, prof_name, to, course_code )

    # send to self for testing (content, from, to) should be there
    smtp.send_message(content, from, to)

  end
end
