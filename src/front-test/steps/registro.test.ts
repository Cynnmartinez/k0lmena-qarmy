import { expect } from '@playwright/test';
import { Given, When, Then } from '@cucumber/cucumber';
import { BASEURL } from '../config';
import { pages } from '../hooks/hook';
import {
  inputEmail,
  inputPass,
  inputNombre,
} from '../locators/registroLocators';
import {
  getByLocatorAndFillIt,
} from '../utils/interactions';

/* -------------------------
   Navegación inicial
------------------------- */
Given('El usuario se encuentra en la pagina de registro de Github', async () => {
  for (const page of pages) {
    console.log(`Ejecutando prueba en navegador: ${page.context().browser()?.browserType().name()}`);
    await page.goto(BASEURL);
  }
});

/* -------------------------
   Step GENÉRICO para completar campos
   (reemplaza los steps específicos)
------------------------- */
When('El usuario completa el campo {string} con {string}', async function (campo: string, valor: string) {
  for (const page of pages) {
    const key = campo.trim().toUpperCase();
    switch (key) {
      case 'EMAIL':
        await getByLocatorAndFillIt(page, inputEmail, valor);
        break;
      case 'CONTRASEÑA':
        await getByLocatorAndFillIt(page, inputPass, valor);
        break;
      case 'USERNAME':
        await getByLocatorAndFillIt(page, inputNombre, valor);
        break;
      default:
        throw new Error(`Campo no mapeado: ${campo}`);
    }
  }
});

/* -------------------------
   Dropdown País
------------------------- */
When('El usuario hace click en el dropdown pais', async function () {
  for (const page of pages) {
    const dropdown = page.locator('button.country-select-button');
    await dropdown.scrollIntoViewIfNeeded();
    await dropdown.click();
  }
});

/* -------------------------
   Buscar y SELECCIONAR país (única definición)
------------------------- */
When('El usuario escribe {string} en el campo de busqueda y lo selecciona', async function (texto: string) {
  for (const page of pages) {
    const searchInput = page.locator('input[type="search"], input[placeholder*="Buscar" i]');
    await searchInput.first().fill(texto);

    const option = page.getByRole('option', { name: new RegExp(texto, 'i') }).first();
    await option.waitFor({ state: 'visible', timeout: 5000 });
    await option.click(); // seleccionar para cerrar overlay
  }
});

/* -------------------------
   Click en CREATE ACCOUNT
------------------------- */
When('El usuario hace click en el boton CREATE ACCOUNT', async function () {
  for (const page of pages) {
    const button = page.getByRole('button', { name: /CREATE ACCOUNT/i });
    await button.scrollIntoViewIfNeeded();
    await button.click();
  }
});

/* -------------------------
   Then POSITIVO: llegó a confirmación
------------------------- */
Then('El usuario deberia ser redireccionado a la pantalla de confirmacion de email', async function () {
  for (const page of pages) {
    await page.waitForLoadState('networkidle', { timeout: 8000 }).catch(() => {});
    await expect(page.locator('body')).toContainText(
      /Verification complete!|Verify your account|Enter code|Confirm your email address/i,
      { timeout: 20000 }
    );
  }
});

/* -------------------------
   Then NEGATIVOS
------------------------- */
Then('El sistema deberia permanecer en la pagina de registro', async function () {
  for (const page of pages) {
    await expect(page).toHaveURL(/signup|register|join/i, { timeout: 10000 });
  }
});

Then('El usuario deberia ver un mensaje de error', async function () {
  for (const page of pages) {
    const anyError = /Email is invalid|already taken|Email cannot be blank|Password is too short|Password cannot be blank|Username cannot be blank|Username may only contain|is not valid|There was a problem/i;
    await expect(page.locator('body')).toContainText(anyError, { timeout: 15000 });
  }
});