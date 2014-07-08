require 'spec_helper'

describe "Creating todo_lists" do
	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is what I'm doing today."

		visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")

        fill_in "Title", with: options[:title]
        fill_in "Description", with: options[:description]
        click_button "Create Todo list"
	end

	it "redirects to the todo list index page on success" do
		create_todo_list

        expect(page).to have_content("My todo list")
    end

    it "displays an error when the todo list has no title" do
    	expect(TodoList.count).to eq(0)

    	create_todo_list title:"", description:"dsfsd"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what im doing")
	end 
	
	it "displays an error when the todo list has a title less than 3 char" do
    	expect(TodoList.count).to eq(0)

    	create_todo_list title:"hi", description:"posdnfksdf"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what im doing")
	end 

	it "displays an error when the todo list doesn't have a description" do
    	expect(TodoList.count).to eq(0)

    	create_todo_list title:"dsfsd", description:""
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what im doing")
	end 

	it "displays an error when the todo list doesn't have a description greater than 5 characters" do
    	expect(TodoList.count).to eq(0)

    	create_todo_list title:"sdfsd", description:"sd"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what im doing")
	end 
end