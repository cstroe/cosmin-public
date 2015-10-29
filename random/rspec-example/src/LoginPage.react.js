'use strict';

var React = require('react');

var LoginPage = React.createClass({
	contextTypes: {
		onAuthenticateSuccess: React.PropTypes.func.isRequired
	},

	getInitialState: function() {
		return {
			username: '',
			password: ''
		};
	},

	onFailure: function(error) {
		this.setState({ error: error });
	},

	submit: function(event) {
		event.preventDefault()

		var username = this.state.username;
		var password = this.state.password;

		if(username === "test@example.com" && password === "password") {
			this.context.onAuthenticateSuccess()
		} else {
			this.onFailure("Invalid credentials");
		}
	},

	changeUsername: function(event) {
		this.setState({ username: event.target.value });
	},

	changePassword: function(event) {
		this.setState({ password: event.target.value });
	},

	getError: function() {
		return this.state.error || this.props.error || '';
	},

	render: function() {
		return (
			<div className="login">
				<div className='login-body'>
					<h5>Login to your Todos</h5>

					<form onSubmit={ this.submit }>
						<label htmlFor='username'>Username</label>
						<input id='username' type='text' required='required' onChange={ this.changeUsername } />

						<label htmlFor='password'>Password</label>
						<input id='password' type='password' required='required' onChange={ this.changePassword } />

						{ this.getError() }

						<input type='submit' value='Login' />
					</form>
				</div>
			</div>
		);
	}

});

module.exports = LoginPage;
