import { Actions, PlopGeneratorConfig } from 'node-plop'
import * as path from 'path'
import { baseGeneratorPath } from '../../paths'
import { pathExists } from '../../utils'

export enum TerraformPromptNames {
  'terraformRepository' = 'terraformRepository',
  'terraformStage' = 'terraformStage',
}

type Answers = { [P in TerraformPromptNames]: string }

const terraformPath = path.join(baseGeneratorPath, 'provision', 'terraform', 'us-east-1')

export const terraformGenerator: PlopGeneratorConfig = {
  description: 'add an repository to terraform',
  prompts: [
    {
      type: 'input',
      name: TerraformPromptNames.terraformStage,
      message: 'What should it be stage?',
      default: 'core',
    },
    {
      type: 'input',
      name: TerraformPromptNames.terraformRepository,
      message: 'What should it be name repository called?',
      default: 'repo name',
    },
  ],
  actions: (data) => {
    const answers = data as Answers

    const containerPath = path.join(terraformPath, answers.terraformStage)

    if (!pathExists(containerPath)) {
      throw new Error(`Stage '${answers.terraformStage}' not exists in '${containerPath}' `)
    }

    const actions: Actions = []

    actions.push({
      type: 'append',
      templateFile: './provision/terraform/repository.append.hbs',
      path: `${containerPath}/repositories.tf`,
      abortOnFail: false,
    })

    actions.push({
      type: 'append',
      path: `${containerPath}/outputs.tf`,
      templateFile: './provision/terraform/output.append.hbs',
      abortOnFail: true,
    })

    return actions
  },
}
