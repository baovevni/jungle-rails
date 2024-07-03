describe('User Login', () => {
  it('The form is displayed when user clicks on Register', () => {
    cy.visit('/');
    cy.get('.nav-link').contains('Register').click();
    cy.get('form').should('be.visible');
  });

  it('User can register', () => {
    cy.visit('/');
    cy.get('.nav-link').contains('Register').click();
    cy.get('#user_first_name').type('test');
    cy.get('#user_last_name').type('user');
    cy.get('#user_email').type('user@test.com');
    cy.get('#user_password').type('password');
    cy.get('#user_password_confirmation').type('password');
    cy.get('.actions > input').click();
    cy.get('.alert').contains('Account created successfully.').should('be.visible');
    cy.get('.nav-link').contains('Logout').should('be.visible');

  });

  it('The form is displayed when user clicks on Login', () => {
    cy.visit('/');
    cy.get('.nav-link').contains('Login').click();
    cy.get('form').should('be.visible');
  });

  it('User can login and Logout', () => {
    cy.visit('/');
    cy.get('.nav-link').contains('Login').click();
    cy.get('#email').type('user@test.com');
    cy.get('#password').type('password');
    cy.get('.actions > input').click();
    cy.get('.alert').should('be.visible');
    cy.get('.nav-link').contains('Logout').should('be.visible');
    cy.get('.nav-link').contains('Logout').click();
    cy.get('.nav-link').contains('Login').should('be.visible');
  });

});
