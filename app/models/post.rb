class Post < ActiveRecord::Base
	
	searchable do
		text :title, :link, :details, :institution
	end
end
