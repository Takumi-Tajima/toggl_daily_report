import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["togglCheckbox", "githubCheckbox", "contentTextarea"]

  async generate() {
    const includeToggl = this.togglCheckboxTarget.checked
    const includeGithub = this.githubCheckboxTarget.checked

    if (!includeToggl && !includeGithub) {
      return
    }

    const query = this.buildQuery(includeToggl, includeGithub)

    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
    const response = await fetch('/graphql', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
      body: JSON.stringify({ query: query })
    })

    const result = await response.json()

    this.contentTextareaTarget.value = this.formatResult(result.data)
  }

  buildQuery(includeToggl, includeGithub) {
    const fields = []
    if (includeToggl) {
      fields.push(`
        todaysTogglEntries {
          description
          start
          stop
          duration
        }
      `)
    }
    if (includeGithub) {
      fields.push(`
        todaysGithubPullRequests {
          title
          url
          createdAt
        }
      `)
    }
    return `{ ${fields.join('\n')} }`
  }

  formatResult(data) {
    let lines = []

    if (data.todaysTogglEntries) {
      lines.push('やったこと')
      const togglLines = []
      data.todaysTogglEntries.forEach(entry => {
        const startTime = this.formatTime(entry.start)
        const stopTime = entry.stop ? this.formatTime(entry.stop) : '作業中'
        const duration = this.formatDuration(entry.duration)
        const description = entry.description || '(説明なし)'
        togglLines.unshift(`   ${startTime} ~ ${stopTime} ${description} ${duration}`)
      })
      lines.push(...togglLines)
    }

    if (data.todaysGithubPullRequests && data.todaysGithubPullRequests.length > 0) {
      lines.push('作成したPR')
      data.todaysGithubPullRequests.forEach(pr => {
        lines.push(`   ${pr.title}`)
        lines.push(`      ${pr.url}`)
      })
    }

    return lines.join('\n')
  }

  formatTime(isoString) {
    const date = new Date(isoString)
    const hours = date.getHours().toString().padStart(2, '0')
    const minutes = date.getMinutes().toString().padStart(2, '0')
    return `${hours}:${minutes}`
  }

  formatDuration(seconds) {
    if (seconds < 0) {
      return '(作業中)'
    }
    const hours = Math.floor(seconds / 3600)
    const minutes = Math.floor((seconds % 3600) / 60)
    if (hours > 0) {
      return `${hours}h ${minutes}m`
    }
    return `${minutes}m`
  }
}
