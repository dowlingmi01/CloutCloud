module ApplicationHelper

	def source_helper
		if session[:source]
			greeting = "Thanks for visiting me from #{session[:source]}"
			content_tag(:p, greeting, class: "source-greeting")
		end
	end

	def full_title(page_title = " ")
		default_title = "Clout Cloud"
		if page_title.empty?
			default_title
		else
			"#{page_title} | #{default_title}"
		end
	end

	def time_format(survey_date)
		survey_date.strftime("%A, %d %b %Y %l:%M %p")
	end

	def survey_status(survey)
		if survey.end_date <= Date.today
			content_tag(:span, "", class: "past")
		else
			content_tag(:span, "", class: "upcoming")
		end		
	end

end
