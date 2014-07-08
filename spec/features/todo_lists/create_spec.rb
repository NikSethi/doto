require 'spec_helper'

describe "Creating todo_lists" do
	it "redirects to the todo list index page on success" do
		visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")

        fill_in "Title", with: "My todo list"
        fill_in "Description", with: "This is what im doing"
        click_button "Create Todo list"

        expect(page).to have_content("My todo list")
    end

    it "displays an error when the todo list has no title" do
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")

        fill_in "Title", with: ""
        fill_in "Description", with: "This is what im doing"
        click_button "Create Todo list"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what im doing")
	end 
	
	it "displays an error when the todo list has a title less than 3 char" do
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")

        fill_in "Title", with: "hi"
        fill_in "Description", with: "This is what im doing"
        click_button "Create Todo list"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what im doing")
	end 

	it "displays an error when the todo list doesn't have a description" do
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")

        fill_in "Title", with: "ehi"
        fill_in "Description", with: ""
        click_button "Create Todo list"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what im doing")
	end 

	it "displays an error when the todo list doesn't have a description greater than 5 characters" do
    	expect(TodoList.count).to eq(0)

    	visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")

        fill_in "Title", with: "ehi"
        fill_in "Description", with: "dsfs"
        click_button "Create Todo list"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what im doing")
	end 
end