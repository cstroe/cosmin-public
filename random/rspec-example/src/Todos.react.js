var React = require('react');

var TodoListItem = React.createClass({
	render: function() {
		return <li>{this.props.title}</li>
	}
});

var TodoList = React.createClass({
	contextTypes: {
		todos: React.PropTypes.array.isRequired,
		onNewTodo: React.PropTypes.func.isRequired
	},

	onSubmit: function(ev) {
		ev.preventDefault();
		this.context.onNewTodo(this.refs.todoText.value)

		this.refs.todoText.value = "";
	},

	render: function() {
		return (
			<div id="todo-app">
				<form onSubmit={this.onSubmit}>
					<input type="text" name="text" ref="todoText" />
					<input type="submit" />
				</form>

				<ul>
					{
						this.context.todos.map(function(text, idx) {
							return <TodoListItem title={text} key={idx} />
						})
					}
				</ul>
			</div>
		);
	}
});


module.exports = TodoList;
