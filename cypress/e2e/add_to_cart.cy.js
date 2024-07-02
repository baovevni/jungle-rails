describe('Add to cart', () => {
  it('User can add product to the cart from homepage', () => {
    cy.visit('/');
    cy.get(':nth-child(1) > div > .button_to > .btn').click();
    cy.get('.nav-link').contains('My Cart (1)');
  });

  it("User can click on any product and add it to the cart", () => {
    cy.visit('/');
    cy.get(".products article").first().click();
    cy.get(".product-detail button").click();
    cy.get('.nav-link').contains('My Cart (1)');
  });

});