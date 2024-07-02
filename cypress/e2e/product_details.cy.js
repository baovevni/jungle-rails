describe('Home Page', () => {
  it('should visit the home page', () => {
    cy.visit('/');
  });

  it("User can click on any product", () => {
    cy.visit('/');
    cy.get(".products article").first().click();
  });

  it("User can see the product details", () => {
    cy.visit('/');
    cy.get(".products article").first().click();
    cy.get(".product-detail").should("be.visible");
  });

  it("Product image is visible", () => {
    cy.visit('/');
    cy.get(".products article").first().click();
    cy.get(".product-detail img").should("be.visible");
  });

  it("Add button is visible", () => {
    cy.visit('/');
    cy.get(".products article").first().click();
    cy.get(".product-detail button").should("be.visible");
  })
});