FactoryGirl.define do

 factory :user do 
    name			"Mikahil"
    email	                "h02-GerasimovMN@a.ru"
    password              		"Cegth1Yjdsq2Gfhjkm3"
    password_confirmation 		"Cegth1Yjdsq2Gfhjkm3"
 end
 
 factory :cash do
     factory :cash_a do
	name	"Cash_A"
        balance	1654.23
	user	:user
     end
 
     factory :cash_b do
	name	"Cash_B"
        balance	523.57
	user	:user
     end
 end
 
end

