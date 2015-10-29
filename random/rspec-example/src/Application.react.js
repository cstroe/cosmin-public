'use strict';

var React = require('react');
var LoginPage = require('./LoginPage.react');
var TodoList = require('./Todos.react');

var Application = React.createClass({
	getInitialState: function() {
		return { component: <LoginPage />, todos: [], isAuthed: false };
	},

	childContextTypes: {
		onAuthenticateSuccess: React.PropTypes.func.isRequired,
		onNewTodo: React.PropTypes.func.isRequired,
		todos: React.PropTypes.array.isRequired,
	},

	getChildContext: function() {
		return {
			onAuthenticateSuccess: this.onAuthenticateSuccess,
			onNewTodo: this.onNewTodo,
			todos: this.state.todos
		};
	},

	onAuthenticateSuccess: function(response) {
		this.setState({ isAuthed: true, component: <TodoList /> });
	},

	onNewTodo: function(text) {
		this.setState({ todos: this.state.todos.concat(text) });
	},

	componentWillMount: function() {
		if (this.state.isAuthed) {
			this.setState({ component: <TodoList /> });
		} else {
			this.setState({ component: <LoginPage /> });
		}
	},

	render: function() {
		return this.state.component;
	}
});

module.exports = Application;
