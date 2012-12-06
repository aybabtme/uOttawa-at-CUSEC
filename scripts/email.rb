# encoding: UTF-8
require 'tlsmail'
require 'time'
require 'parseconfig'

#
# Configuration
#

# profs, those commented out have already been contacted
prof_course = {
  # "Dan Ionescu" => ["ionescu@site.uottawa.ca", "SEG4145"],
  # "Dimitrios Makrakis" => ["dimitris@site.uottawa.ca", "CEG4190"],
  # "Gregor v. Bochmann" => ["bochmann@eecs.uottawa.ca", "SEG2106"],
  # "Timothy Lethbridge" => ["tcl@eecs.uottawa.ca", "SEG/CEG/ELG2911"],
  # "Karelyn Davis" => ["kdavi6@uOttawa.ca", "MAT2377"],
  # "Herna Viktor" => ["hlviktor@eecs.uottawa.ca", "CSI2101 and CSI2132"],
  # "Ahmed Kharmouch" => ["karmouch@site.uottawa.ca", "ITI1500"],
  # "Mountassir M'Hammed" => ["mmountas@uOttawa.ca", "MAT2777"],
  # "Joseph Khoury" => ["jkhoury@uottawa.ca", "MAT1748"],
  # "Matthew McLennan" => ["mmcle020@uOttawa.ca", "PHI2794"],
  # "Christian Gigault" => ["cgigault@uOttawa.ca", "PHY2723"],
  # "Liam Peyton" => ["lpeyton@site.uottawa.ca", "SEG4910"],
  # "Liam Peyton" => ["lpeyton@uottawa.ca", "SEG4910"],
  # "Rafael Falcon" => ["rfalcon@uottawa.ca", "CSI4106"],
  # "Emad Gad" => ["egad@eecs.uottawa.ca", "ELG2136"],
  # "Claude Théoret" => ["ctheoret@uottawa.ca", "ECO1102"],
  # "Omar Badreddin" => ["obadr024@uottawa.ca", "CSI2120"],
  # "Omar Badreddin" => ["oobahy@gmail.com", "CSI2120"],
  # "Nejib Zaguia" => ["zaguia@site.uottawa.ca", "CSI2501"],
  # "Robert Laganière" => ["laganier@eecs.uottawa.ca", "CSI2520"],
  # "Fadi Malek" => ["malek@site.uottawa.ca", "CSI2532"],
  # "Fadi Malek" => ["FADI.MALEK@forces.gc.ca", "CSI2532"],
  # "Mahmoud Zarepour" => ["zarepour@uottawa.ca", "MAT2377"],
  # "Philip McIlkenny" => ["mcilkenny@telfer.uOttawa.ca", "ADM1340"],
  # "David Delcorde" => ["delcorde@telfer.uOttawa.ca", "ADM2320"]
  # "Marcel Turcotte" => ["turcotte@eecs.uottawa.ca", "ITI1121"],
  # "Michel Godin" => ["michel.godin@uottawa.ca", "PHY2323"],
  # "Najwa Haddad" => ["nhaddad@uottawa.ca", "PSY1102"]
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
subject: #{course}, some students will be absent
Date: #{Time.now.rfc2822}

Dear prof #{name},

I am contacting you because some students of your #{course} class will be attending a conference from *January 16, 19h* until *January 19*.

As you may know, uOttawa will be sending a large delegation of students to CUSEC this year.  CUSEC is a conference for students in fields related to computing.

*I would kindly ask if you could support student attendance to this conference by avoiding  tests, quizzes, assignments or other form of evaluation on those dates.*  This would greatly relieve students as they seek professional and personal development while attending this conference.

The delegation is funded by the Faculty of Engineering's and the Engineering Student Society's endowment funds.  The Faculty (of Engineering) Council also passed a motion this Fall supporting students attendance to such conferences.

Thanks for your time, and please let me know if you have any inquiries regarding the conference or the absence of students. If you would like to have a list of students who will miss your class, let me know and I will send you one.  However, please note that registrations are still open, so the list may change.

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
