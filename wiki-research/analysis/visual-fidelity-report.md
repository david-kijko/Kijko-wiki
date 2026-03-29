# Visual Fidelity Report -- SuperMemory Docs Audit

> Audited: 2026-03-28 | Source: 15 full-page screenshots | Compared against: `page-type-templates.json` design_tokens
> Auditor: Team 4 (Aesthetic Fidelity)

---

## Overall Fidelity Score: 7.5 / 10

Our design tokens capture the broad strokes well -- layout geometry, font families, core color palette, and component inventory are directionally correct. However, there are meaningful gaps in header/nav bar design, footer structure, code block details, sidebar rendering, API reference two-column layout, changelog layout, badge styling, and several interactive UI micropatterns (feedback widgets, copy-page buttons, AI search, settings gear) that are either undocumented or imprecisely specified.

---

## 1. Layout Accuracy

### What Matches

| Token | Value | Observed | Verdict |
|-------|-------|----------|---------|
| `content_max_width` | 780px | Content area on standard pages (authentication, concepts, quickstart) visually consistent with ~750-800px | CORRECT |
| `sidebar_width` | 280px | Left sidebar on most pages appears ~260-280px | CORRECT (close enough) |
| `toc_width` | 220px | Right-rail "On this page" column on authentication, concepts pages ~200-220px | CORRECT |
| `container_padding` | 2rem | Visible padding around content area is consistent | CORRECT |
| `section_gap` | 2.5rem | Vertical spacing between H2 sections appears ~2-2.5rem | CORRECT |
| `card_grid_gap` | 1rem | Card grid gaps on memorybench_overview, intro, vibe-coding ~1rem | CORRECT |

### What Does NOT Match or Is Missing

1. **Header bar height and structure**: Not specified in tokens. The top navigation bar is approximately 56-64px tall with a fixed/sticky position. It contains: logo (left), search bar (center-left), "Ask AI" button (center-right), "Support" link, "Dashboard" CTA button (right), and a settings gear icon (far right).

2. **Horizontal tab navigation below header**: A second navigation row sits below the header. It contains icon+text tab links (Developer Platform, API Integrations, Plugins, API Reference, MemoryBench, Cookbook, Changelog). The active tab has a dark underline indicator. This entire bar is NOT in our layout tokens.

3. **API Reference two-column layout**: The `api-reference_memories_create-memories-directly.png` screenshot shows a fundamentally different layout -- the right side has a dark code example panel (approximately 40% width) alongside the parameter docs on the left (~60%). Our tokens only describe single-column content. This is a critical gap.

4. **Changelog layout**: The `changelog_overview.png` shows a unique timeline/log layout with date-grouped entries, each containing version badges, descriptions, and nested content. No sidebar navigation is visible; instead, a flat scrollable list. This layout is NOT captured in our tokens.

5. **Footer structure**: The footer contains three rows: (a) Previous/Next page navigation with arrows, (b) social icons (GitHub, LinkedIn, X/Twitter), and (c) "Powered by mintlify" branding text. Our tokens mention none of this.

6. **Breadcrumb placement**: Breadcrumbs appear above the H1 title as small gray text (e.g., "Concepts" above "Authentication"). This is mentioned in universal_patterns but has no token for size, color, or spacing.

---

## 2. Color Scheme Corrections

### Light Mode (Primary mode observed in all screenshots)

| Token | Our Value | Observed | Action |
|-------|-----------|----------|--------|
| `background` | #ffffff | White confirmed across all pages | CORRECT |
| `foreground` | #1a1a2e | Heading text is very dark, near-black. Body text appears slightly lighter. #1a1a2e is reasonable for headings but body may be closer to #374151 or #4b5563 | INVESTIGATE -- body text may differ from heading text |
| `muted` | #6b7280 | Breadcrumb text, captions, and secondary text match this gray range | CORRECT |
| `border` | #e5e7eb | Card borders and horizontal rules match this light gray | CORRECT |
| `accent` | #7c3aed | Links in "On this page" ToC and some inline links appear blue (#2563eb or similar), NOT purple. The active tab underline is dark/black, not purple. | INCORRECT -- primary link color appears to be blue (~#2563eb), not purple. Purple may only appear in specific branded elements. |
| `accent_hover` | #6d28d9 | Not directly observable from static screenshots | UNVERIFIED |
| `code_bg` | #f5f5f5 | Inline code backgrounds on authentication page appear very light gray, consistent with #f5f5f5 | CORRECT |
| `callout_info_bg` | #eff6ff | Blue callouts on connector_github (plan requirement) and integration pages show light blue bg | CORRECT |
| `callout_info_border` | #3b82f6 | Left border on info callouts is blue, consistent | CORRECT |
| `callout_warning_bg` | #fffbeb | Yellow/amber callout on deployment_self-hosting shows warm light bg | CORRECT |
| `callout_warning_border` | #f59e0b | Amber/yellow left border visible | CORRECT |
| `callout_tip_bg` | #ecfdf5 | Green callout on vibe-coding shows light green bg | CORRECT |
| `callout_tip_border` | #10b981 | Green left border visible | CORRECT |
| `callout_note_bg` | #f3f4f6 | Gray callouts visible on some pages | CORRECT |
| `callout_note_border` | #9ca3af | Gray left border on note callouts | CORRECT |
| `card_bg` | #ffffff | Cards on memorybench_overview are white with border | CORRECT |
| `card_border` | #e5e7eb | Light gray card borders match | CORRECT |
| `card_hover_shadow` | 0 4px 12px rgba(0,0,0,0.08) | Not observable in static screenshots | UNVERIFIED |

### Specific Color Corrections Needed

1. **Accent color is BLUE, not purple for most interactive elements.** The ToC active link on authentication.png is clearly blue (approximately #2563eb). Internal links in body text also appear blue. Recommend changing `accent` to `#2563eb` or introducing separate `link_color` and `brand_accent` tokens.

2. **Code block header/tab bar**: The code block tab strip (cURL / TypeScript / Python) has a light gray background (~#f9fafb) with a bottom border. The active tab has a slightly darker bottom indicator. Not captured.

3. **API method badges**: On the API reference page, HTTP method badges use specific colors:
   - POST: Blue background (#2563eb text or bg)
   - GET: Green
   - PUT: Orange/amber
   - DELETE: Red
   These are entirely absent from our color tokens.

4. **Dark-themed images/screenshots**: The embedded product screenshots (dashboard UI, graph visualizations) within pages use a dark theme (#0f1117-range backgrounds). These are content images, not page chrome, but worth noting.

5. **"Dashboard" CTA button**: Uses a dark/black background with white text and a right-arrow chevron. This is a primary CTA pattern not in our tokens.

---

## 3. Typography Corrections

| Token | Our Value | Observed | Action |
|-------|-----------|----------|---------|
| `font_body` | Inter, system-ui, sans-serif | Text appears to be Inter or a very similar geometric sans-serif. | CORRECT |
| `font_code` | JetBrains Mono, Fira Code, monospace | Code blocks show a clean monospace font consistent with this stack | CORRECT |
| `font_heading` | Inter, system-ui, sans-serif | Headings use the same sans-serif family | CORRECT |
| `h1.size` | 2rem (32px) | H1 on authentication.png "Authentication" appears approximately 28-32px. Acceptable. | CORRECT |
| `h1.weight` | 700 | H1 is bold/heavy | CORRECT |
| `h2.size` | 1.5rem (24px) | H2 "API Keys", "Connector Branding" on authentication appear ~22-24px | CORRECT |
| `h2.weight` | 600 | Semibold. Confirmed visually. | CORRECT |
| `h3.size` | 1.25rem (20px) | H3 visible on some pages, appears ~18-20px | CORRECT |
| `h3.weight` | 500 | Medium weight. Consistent. | CORRECT |
| `body.size` | 1rem (16px) | Body text appears 15-16px | CORRECT |
| `body.line_height` | 1.7 | Line spacing is generous. 1.7 is plausible. | CORRECT |
| `code.size` | 0.875rem (14px) | Code in blocks appears ~13-14px | CORRECT |

### Typography Gaps

1. **Breadcrumb typography**: Small text above H1, appears ~12-13px (0.75-0.8125rem), weight 400, color muted gray. Not tokenized.

2. **"Copy page" button text**: Appears next to H1 as a small ghost button with clipboard icon + "Copy page" text. ~13px, gray, with a dropdown chevron. Not tokenized.

3. **ToC heading "On this page"**: ~13px, weight 500-600, dark text. The ToC links themselves are ~13-14px, weight 400, with the active item in blue/accent color. Not tokenized.

4. **Card title typography**: Card titles (on memorybench_overview) appear ~16px weight 600. Card descriptions are ~14px weight 400 in muted color. Not in typography tokens.

5. **Tab label typography**: The horizontal section tabs (Developer Platform, API Integrations, etc.) are ~14px weight 400-500, with icons preceding text. Active tab appears weight 500 with dark underline. Not tokenized.

6. **Footer nav typography**: "Previous" / "Next" navigation text is ~14px, with the page title in weight 500-600. The actual navigation label ("Customization", "Add context") is a separate line.

7. **Badge typography**: API method badges (POST, GET) use ~11-12px uppercase weight 600 text. Parameter "required" badges use similar small sizing. Not tokenized.

---

## 4. Missing Visual Elements

### 4.1 Header / Navigation Bar (CRITICAL GAP)

The header is the most visually prominent element on every page and is almost entirely undocumented:

- **Logo**: Supermemory logomark (stylized "M" or similar) at far left, approximately 24-28px
- **Search bar**: Center-positioned, pill-shaped input with magnifying glass icon, placeholder "Search...", and "Ctrl K" keyboard shortcut badge on the right side
- **"Ask AI" button**: Adjacent to search, with a sparkle/star icon and "Ask AI" text. This is a distinct AI-powered search feature separate from standard search.
- **"Support" link**: Plain text link, right-aligned
- **"Dashboard" CTA**: Dark/black filled button with white text "Dashboard >" with a right-pointing chevron/arrow. This is the primary CTA.
- **Settings gear icon**: Small cog icon at the far right of the header

**Recommended token addition:**
```json
"header": {
  "height": "60px",
  "background": "#ffffff",
  "border_bottom": "1px solid #e5e7eb",
  "position": "sticky",
  "logo_size": "28px",
  "search_bar_width": "240px",
  "search_bar_border_radius": "9999px",
  "cta_button_bg": "#111827",
  "cta_button_text": "#ffffff",
  "cta_button_border_radius": "0.5rem"
}
```

### 4.2 Section Tab Bar (CRITICAL GAP)

Below the header, a horizontal tab bar provides section-level navigation:

- Each tab has an icon (small, ~16px) + text label
- Tabs observed: Developer Platform, API Integrations, Plugins, API Reference, MemoryBench, Cookbook, Changelog
- Active tab has a dark bottom border/underline indicator (~2px)
- Tab text is ~14px, weight 400 (normal), becoming 500 (medium) when active
- The tab bar appears sticky below the header on scroll

**Recommended token addition:**
```json
"section_tabs": {
  "height": "44px",
  "item_font_size": "0.875rem",
  "item_font_weight": 400,
  "item_font_weight_active": 500,
  "icon_size": "16px",
  "active_indicator": "2px solid #111827",
  "gap": "1.5rem",
  "border_bottom": "1px solid #e5e7eb"
}
```

### 4.3 Left Sidebar (PARTIAL GAP)

Our tokens mention sidebar_width but not the sidebar's internal design:

- **Sidebar is NOT visible on all pages.** The memorybench_overview page does NOT show a left sidebar. Neither does the changelog. API reference has its own specialized sidebar (see below). Standard content pages (authentication, concepts, connectors) DO show the sidebar.
- **Section grouping**: Items are grouped under collapsible section headers
- **Active item**: Appears with a subtle background highlight and possibly bolder text
- **Icons**: Small icons (~16px) precede some section headers
- **Indentation**: Nested items are indented ~16-20px from parent
- **Scroll behavior**: Sidebar scrolls independently of main content (sticky)

### 4.4 Code Block Details (PARTIAL GAP)

Our code_block component tokens are good but miss:

- **Tab bar within code blocks**: When language tabs (cURL, TypeScript, Python) appear, they sit in a light gray header bar above the code. The active tab has a bottom indicator.
- **Copy button**: Positioned at top-right of the code block. Small clipboard icon.
- **AI/Sparkle button**: Adjacent to the copy button, there appears to be a second icon button (sparkle/star), possibly for "Explain with AI" or similar. This is NOT documented.
- **Filename headers**: When present, the filename appears in the top-left of the code block header bar in small muted text.
- **Syntax theme**: Code uses a light-background theme (NOT dark) for standard pages. The background is white or very light gray (#f9fafb to #f5f5f5). Syntax colors include: blue for keywords/commands, green for strings, purple/magenta for certain syntax, gray for comments. Our token says "one-dark-pro" which is a DARK theme -- this is INCORRECT for the light mode code blocks.
- **Code block border**: Subtle border (~#e5e7eb) with border-radius ~0.5rem

**Correction needed:**
```json
"code_block": {
  "theme_light": "github-light or similar light theme",
  "theme_dark": "one-dark-pro",
  "header_bg": "#f9fafb",
  "header_border_bottom": "1px solid #e5e7eb",
  "border": "1px solid #e5e7eb",
  "ai_explain_button": true
}
```

### 4.5 Callout Variants

Our callout tokens cover info, warning, tip, note, and danger. From screenshots:

- **Info (blue)**: Confirmed on multiple pages. Left blue border + light blue bg. Has a small blue info-circle icon on the left.
- **Warning (amber/yellow)**: Confirmed on deployment_self-hosting. Left amber border + light yellow bg. Triangle-exclamation icon.
- **Tip (green)**: Confirmed on vibe-coding. Left green border + light green bg. Lightbulb or checkmark icon.
- **Note (gray)**: Confirmed. Left gray border + light gray bg.
- **Danger (red)**: NOT observed in any screenshot but may exist. UNVERIFIED.

**Gap**: Callout icons are not tokenized. Each variant has a distinct icon that should be specified.

```json
"callout_icons": {
  "info": "circle-info",
  "warning": "triangle-exclamation",
  "tip": "lightbulb",
  "note": "circle-info (gray)",
  "danger": "circle-xmark"
}
```

### 4.6 "Was this page helpful?" Feedback Widget

Visible on authentication.png, memorybench_overview.png, and most pages at the bottom of content:

- Text: "Was this page helpful?"
- Two pill/ghost buttons: thumbs-up icon + "Yes", thumbs-down icon + "No"
- Buttons have subtle borders, ~14px text
- Positioned after last content section, before footer navigation

Not in our tokens or component mapping at all.

### 4.7 "Copy page" Button

Visible on authentication.png, memorybench_overview.png next to the H1:

- Ghost button with clipboard icon + "Copy page" text
- Small dropdown chevron (triangle) suggesting additional options
- Positioned at the top-right of the content area, aligned with H1
- ~13px text, muted color, subtle border

### 4.8 Previous / Next Page Navigation

Visible at the bottom of authentication.png:

- Full-width row with left arrow + "Previous page title" on left, "Next page title" + right arrow on right
- Titles appear in weight 500-600
- Light gray border separating from content above

### 4.9 Footer

Observed on authentication.png, memorybench_overview.png:

- **Row 1**: Previous / Next navigation (see above)
- **Row 2**: Social icons -- GitHub (octocat), LinkedIn, X/Twitter logos -- left-aligned, ~20px icons
- **Row 3**: "Powered by mintlify" text -- right-aligned, small muted text with mintlify logo/wordmark

### 4.10 External Link Indicators

On cards that link externally (memorybench_overview "Mem0", "Zep" cards), a small arrow icon (northeast-pointing, ~12px) appears at the top-right of the card, indicating an external link.

### 4.11 Accordion Component

Visible on authentication.png under "Scoped API Keys":

- Chevron icon (right-pointing triangle) on the left
- Lock/shield icon before the title "Container-scoped keys"
- Light gray background bar
- Rounded corners matching card border-radius

### 4.12 Horizontal Rule / Section Divider

Visible between sections on authentication.png:

- Thin horizontal line (#e5e7eb or similar)
- Full content-width
- Used between major H2 sections, not just at the end of the page

---

## 5. Component-by-Component Audit

### Card

| Property | Token Value | Observed | Match |
|----------|-------------|----------|-------|
| border_radius | 0.75rem | Cards on memorybench_overview show rounded corners ~0.75rem | YES |
| padding | 1.25rem | Internal padding appears ~1.25rem | YES |
| has_icon | true | Cards show icons (globe, download, terminal, grid, etc.) at ~24px | YES |
| has_hover_elevation | true | Not verifiable from static screenshots | N/A |

**Gaps:**
- Card icon size not specified (observed ~20-24px)
- Card icon color: appears to be dark/foreground color, monochrome
- External link arrow indicator on some cards
- Card title is ~16px weight 600, description is ~14px weight 400 muted -- not tokenized
- Cards in 2-column grid confirmed, but 3-column grid also observed (memorybench_overview "Works with any memory provider" section has 3 cards in a row)

### Callout

| Property | Token Value | Observed | Match |
|----------|-------------|----------|-------|
| border_radius | 0.5rem | Rounded corners on callouts confirmed | YES |
| border_left_width | 4px | Left colored border ~3-4px confirmed | YES |
| padding | 1rem 1.25rem | Padding appears consistent | YES |
| variants | info, warning, tip, note, danger | info, warning, tip, note confirmed; danger not seen | PARTIAL |

**Gaps:**
- Callout icon (info-circle, exclamation-triangle, etc.) not tokenized
- Callout title/header line: some callouts have a bold first line acting as a title
- Callout links: inline links within callouts retain blue color

### Code Block

| Property | Token Value | Observed | Match |
|----------|-------------|----------|-------|
| border_radius | 0.5rem | Confirmed | YES |
| has_copy_button | true | Copy icon at top-right confirmed | YES |
| has_filename_header | true | Filenames in header confirmed on some blocks | YES |
| has_language_tabs | true | cURL / TypeScript / Python tabs confirmed | YES |
| tab_languages | TS, Python, cURL, Go, Rust | cURL, TypeScript, Python confirmed. Go and Rust NOT observed. | PARTIAL |
| syntax_highlighter | Shiki | Likely correct for Mintlify | ASSUMED |
| theme | one-dark-pro | INCORRECT for light mode. Light mode uses a light syntax theme. | NO |

**Gaps:**
- AI/sparkle button next to copy button
- Tab bar background color (#f9fafb)
- Active tab indicator style
- Light mode syntax theme name (likely github-light or similar)
- Code block line numbering: NOT observed in any screenshot -- lines are not numbered
- Code block border: 1px solid border visible

### Steps

| Property | Token Value | Observed | Match |
|----------|-------------|----------|-------|
| numbered | true | Steps on quickstart show numbered circles | YES |
| vertical_connector | true | Vertical line connecting steps visible | YES |
| step_title_weight | 600 | Step titles appear semibold | YES |

**Gaps:**
- Step number circle diameter (~24-28px)
- Step number circle background color (appears dark/foreground)
- Step number circle text color (white)
- Step number circle font-size (~14px)
- Vertical connector color (~#e5e7eb)
- Vertical connector width (~2px)

### Tabs (Content Tabs)

| Property | Token Value | Observed | Match |
|----------|-------------|----------|-------|
| border_bottom_style | active indicator | Bottom border/underline on active tab confirmed | YES |
| animated_transition | true | Not verifiable from static screenshots | N/A |

**Gaps:**
- Tab label font size (~14px)
- Tab label font weight (400 default, 500 active)
- Active indicator color (dark/foreground)
- Active indicator thickness (~2px)
- Tab padding and spacing

### Accordion

| Property | Token Value | Observed | Match |
|----------|-------------|----------|-------|
| chevron_icon | true | Chevron/triangle visible | YES |
| animated_expand | true | Not verifiable | N/A |

**Gaps:**
- Accordion has an optional left icon (lock icon on auth page)
- Accordion background color when collapsed (~#f9fafb)
- Accordion border and border-radius

### Table

| Property | Token Value | Observed | Match |
|----------|-------------|----------|-------|
| striped | false | Tables on deployment_self-hosting appear non-striped | YES |
| hover_highlight | true | Not verifiable | N/A |
| border_style | horizontal-only | Horizontal borders visible between rows | YES |

**Gaps:**
- Table header row styling (background, font weight)
- Table cell padding
- Table font size

### ImageZoom

Not explicitly tokenized beyond being listed in fumadocs_components.

**Observed:**
- Dark-themed screenshot images embedded in intro.png, concepts_how-it-works.png, quickstart.png
- Images appear to have subtle rounded corners (~0.5rem)
- Images are full content-width
- Possible lightbox/zoom on click (not verifiable from screenshots)

---

## 6. API Reference Special Layout (CRITICAL)

The `api-reference_memories_create-memories-directly.png` screenshot reveals a layout that is fundamentally different from standard pages:

### Two-Column Layout
- **Left column (~60%)**: Endpoint documentation
  - HTTP method badge ("POST") + endpoint path at the top
  - "Try it" button (blue filled button)
  - Authorizations section with field descriptions
  - Body section with parameter fields
  - Response section with status code tabs
- **Right column (~40%)**: Dark-themed code panel
  - Dark background (#1a1a2e or similar)
  - Request example with syntax highlighting
  - Response example below
  - Sticky positioning (follows scroll)

### API-Specific Components Not Tokenized
1. **HTTP Method Badge**: Colored pill/badge
   - POST = Blue background, white text
   - GET = Green background, white text
   - PUT = Orange background, white text
   - DELETE = Red background, white text
   - Font: ~12px, uppercase, weight 600-700, border-radius ~4px

2. **"Try it" Button**: Blue filled button (~#2563eb), white text, appears next to the method badge

3. **Parameter Field Layout**:
   - Field name in weight 600 dark text
   - Type badge (e.g., "string", "object", "boolean") in muted small text
   - "required" badge: Small red/orange text or badge
   - Description text below in normal weight
   - Nested fields indented with subtle left border/indent guide

4. **Response Status Tabs**: Tabs showing "200", "400", etc. with the active one highlighted

5. **API Sidebar**: The API reference page has a specialized left sidebar listing ALL API endpoints grouped by resource. Each endpoint shows its method badge (color-coded) + endpoint name. The current page's endpoint is highlighted.

### Recommended Token Addition
```json
"api_reference_layout": {
  "two_column": true,
  "left_column_width": "60%",
  "right_column_width": "40%",
  "right_panel_bg": "#1a1a2e",
  "right_panel_sticky": true,
  "method_badges": {
    "GET": { "bg": "#10b981", "text": "#ffffff" },
    "POST": { "bg": "#2563eb", "text": "#ffffff" },
    "PUT": { "bg": "#f59e0b", "text": "#ffffff" },
    "DELETE": { "bg": "#ef4444", "text": "#ffffff" },
    "PATCH": { "bg": "#8b5cf6", "text": "#ffffff" }
  },
  "try_it_button": {
    "bg": "#2563eb",
    "text": "#ffffff",
    "border_radius": "0.375rem"
  },
  "required_badge": {
    "color": "#ef4444",
    "font_size": "0.75rem",
    "font_weight": 500
  }
}
```

---

## 7. Changelog Special Layout

The `changelog_overview.png` shows a unique page structure:

- **No left sidebar** visible
- **No right-rail ToC** visible
- **Timeline/log layout**: Date-based groupings, each with:
  - Date header (appears as H2 or similar, bold)
  - Version or feature entries below each date
  - Each entry contains a title, description, and possibly tags/badges
  - Entries appear as a flat vertical list, not cards
- **Very long page**: The screenshot is extremely tall, suggesting many entries
- The section tab bar at top still shows "Changelog" as active tab

### Recommended Token Addition
```json
"changelog_layout": {
  "sidebar": false,
  "toc": false,
  "content_max_width": "780px",
  "entry_spacing": "2rem",
  "date_header_size": "1.25rem",
  "date_header_weight": 600,
  "entry_title_size": "1rem",
  "entry_title_weight": 600,
  "timeline_indicator": false
}
```

---

## 8. Screenshot-Specific Notes

### intro.png (Landing Page)
- Hero section has H1 "Overview -- What is Supermemory?" with a subtitle paragraph
- Two dark-themed product screenshots embedded (dashboard UI, knowledge graph visualization)
- Bullet list with bold lead-in text pattern: "**Bold text**: description"
- "Next Steps" section at bottom with 2-column card grid (4 cards total, 2x2)
- Blue inline links within body text
- The page has the standard sidebar + ToC layout

### quickstart.png (Tutorial)
- Starts with an info callout (blue) containing links -- appears to be a prerequisite/context callout
- Steps component clearly visible with numbered circles (1, 2, 3) connected by vertical lines
- Dark-themed dashboard screenshot showing API key creation
- Code blocks with language tabs (Python, TypeScript)
- "Was this page helpful?" widget at bottom with thumbs up/down + reaction emojis (not just Yes/No -- there are small emoji-style reaction buttons visible)
- Previous/Next navigation visible at bottom

### concepts_how-it-works.png (Concept)
- Two-card comparison section ("Documents" vs "Memories" or similar) near top with icon+bullet layout
- Tables visible mid-page with horizontal borders
- Dark-themed architecture diagram/visualization
- Code blocks showing data structures (JSON)
- Multiple H2 sections with substantial content
- Standard sidebar + ToC layout

### concepts_memory-vs-rag.png (Comparison Concept)
- Very long page with many sections
- Side-by-side comparison cards (2-column) for Documents vs Memories with bullet lists
- Code blocks with language tabs (appears to be showing before/after or comparison code)
- Numbered steps section visible
- "The Bottom Line" section near the end with a callout/summary
- "Next Steps" cards at the very bottom

### integrations_claude-code.png (Integration)
- Product logo/image near top -- appears as a brown/amber-toned image card, NOT a simple icon. This is an actual product screenshot or branding image.
- Info callout with external link to partner docs
- Table ("What Gets Synced") with multiple columns
- "Commands" section listing available commands
- "Configuration" section with environment variables
- Code blocks showing config file content (JSON)
- Standard layout with sidebar + ToC

### integrations_mastra.png (Long Integration)
- Extremely long page -- one of the longest observed
- Multiple code blocks throughout
- Standard layout throughout
- Many H2 sections
- No special layout deviations from standard integration template

### connectors_github.png (Connector)
- Warning/Info callout near top (yellow/amber, possibly plan-requirement callout)
- Language tabs (Python, TypeScript, cURL) on multiple code blocks
- "Supported Document Types" section with a list
- "Synchronizing with Webhooks" section
- Another callout (appears yellow/warning) mid-page
- "Connection Management" section with multiple sub-operations
- "Advanced Configuration" section toward bottom
- Accordion component visible for advanced/collapsible content

### api-reference_memories_create-memories-directly.png (API Reference)
- Two-column layout as detailed in Section 6
- Left: parameter docs with expandable fields
- Right: dark code panel with request/response examples
- Method badge (POST) + path prominently displayed
- "Try it" blue button
- Specialized API sidebar listing all endpoints with method badges
- "Was this page helpful?" widget below main content
- Previous/Next navigation shows "Merge container tags" / "Forget a memory"

### cookbook_personal-assistant.png (Cookbook)
- Extremely long page
- Table of contents in right rail suggests many sections
- Code blocks throughout with filenames in headers
- Standard layout
- The screenshot is so long that individual details are difficult to discern at this resolution

### memorybench_overview.png (Product Overview)
- Clean landing page layout
- NO left sidebar visible
- 2-column card grid (Web Interface + Installation, CLI Reference + Architecture, MemScore solo)
- 3-column card grid for "Works with any memory provider" (Supermemory, Mem0, Zep) -- external link arrows on Mem0 and Zep cards
- Info callout with blue text and links ("We're actively adding support...")
- "Contribute" section with a single wide card ("Report Issue")
- "Was this page helpful?" visible
- "MemoryBench on GitHub" link at bottom-right (text link with right arrow)
- Footer with social icons + "Powered by mintlify"

### deployment_self-hosting.png (Deploy Guide)
- Warning callout at the top (amber/yellow) -- likely a "this is advanced" warning
- Multiple H2 sections with code blocks
- Configuration tables visible
- Very long page with many code examples
- Standard layout with sidebar + ToC

### changelog_overview.png (Changelog)
- Unique layout as described in Section 7
- Very long vertical list of entries
- No sidebar navigation
- Date groupings visible
- Minimal use of cards or special components

### migration_from-mem0.png (Migration)
- "Migrating from Mem0 to Supermemory" title
- Before/after code block comparisons
- Numbered steps with step titles
- Multiple code blocks with language tabs
- "API Migration Reference" section near bottom showing side-by-side code comparisons
- "Next Steps" cards at bottom
- Standard layout

### authentication.png (Auth Page)
- Clean, medium-length page
- Clear H2 sections: API Keys, Connector Branding, Scoped API Keys
- Code block with tabs (cURL, TypeScript, Python)
- Accordion under "Scoped API Keys"
- "Was this page helpful?" widget clearly visible
- Previous/Next navigation: "Customization" / "Add context"
- Horizontal rule dividers between sections
- Footer with social icons

### vibe-coding.png (Vibe Coding)
- Breadcrumb "Concepts" visible above H1
- "Copy page" button + "Vibe code" label visible near H1
- 3-card grid at top for quick setup options (MCP, Canny Prompt, Claude Code MCP)
- "MCP Server" section with installation code
- Multiple language/platform tabs (npm, npx, docker, pnpm, yarn, bunx, deno)
- Green/Tip callout with important note
- "Next Steps" section with 4 cards in 2x2 grid
- Standard layout with sidebar + ToC

---

## 9. Recommended Design Token Updates

### Priority 1: Critical Fixes

```json
{
  "design_tokens.colors.light.accent": "#2563eb",
  "design_tokens.colors.light.accent_hover": "#1d4ed8",
  "COMMENT": "Primary interactive color is blue, not purple. Add separate brand_purple if needed.",

  "design_tokens.components.code_block.theme": "REMOVE or rename to theme_dark",
  "design_tokens.components.code_block.theme_light": "github-light",
  "design_tokens.components.code_block.theme_dark": "one-dark-pro",
  "design_tokens.components.code_block.border": "1px solid #e5e7eb",
  "design_tokens.components.code_block.header_bg": "#f9fafb",
  "design_tokens.components.code_block.ai_button": true
}
```

### Priority 2: New Sections to Add

```json
{
  "design_tokens.layout.header": {
    "height": "60px",
    "background": "#ffffff",
    "border_bottom": "1px solid #e5e7eb",
    "position": "sticky",
    "search_width": "240px",
    "search_border_radius": "9999px",
    "search_shortcut_badge": "Ctrl K",
    "ai_search_button": true,
    "cta_button": {
      "text": "Dashboard",
      "bg": "#111827",
      "text_color": "#ffffff",
      "border_radius": "0.5rem",
      "has_arrow": true
    },
    "settings_icon": true,
    "support_link": true
  },

  "design_tokens.layout.section_tabs": {
    "height": "44px",
    "border_bottom": "1px solid #e5e7eb",
    "item_font_size": "0.875rem",
    "item_icon_size": "16px",
    "active_indicator": "2px solid #111827",
    "position": "sticky"
  },

  "design_tokens.layout.sidebar": {
    "width": "280px",
    "position": "sticky",
    "collapsible_sections": true,
    "section_header_icon": true,
    "active_item_bg": "#f3f4f6",
    "indent_per_level": "16px",
    "visible_on": ["standard_pages"],
    "hidden_on": ["changelog", "memorybench_overview"]
  },

  "design_tokens.layout.footer": {
    "prev_next_navigation": true,
    "social_icons": ["github", "linkedin", "x-twitter"],
    "powered_by": "mintlify",
    "border_top": "1px solid #e5e7eb"
  },

  "design_tokens.layout.api_reference": {
    "two_column": true,
    "left_width": "60%",
    "right_width": "40%",
    "right_panel_bg_dark": "#1a1a2e",
    "right_panel_sticky": true,
    "dedicated_sidebar": true
  },

  "design_tokens.layout.changelog": {
    "sidebar": false,
    "toc": false,
    "entry_based_layout": true,
    "date_grouped": true
  },

  "design_tokens.components.feedback_widget": {
    "text": "Was this page helpful?",
    "buttons": ["Yes", "No"],
    "icons": ["thumbs-up", "thumbs-down"],
    "additional_reactions": true,
    "button_style": "ghost",
    "position": "after_content"
  },

  "design_tokens.components.copy_page_button": {
    "position": "top-right aligned with H1",
    "icon": "clipboard",
    "text": "Copy page",
    "has_dropdown": true,
    "style": "ghost"
  },

  "design_tokens.components.breadcrumb": {
    "font_size": "0.8125rem",
    "font_weight": 400,
    "color": "#6b7280",
    "position": "above H1",
    "separator": "none (single level observed)"
  },

  "design_tokens.components.method_badge": {
    "font_size": "0.75rem",
    "font_weight": 700,
    "text_transform": "uppercase",
    "border_radius": "0.25rem",
    "padding": "0.125rem 0.5rem",
    "variants": {
      "GET": { "bg": "#10b981", "text": "#ffffff" },
      "POST": { "bg": "#2563eb", "text": "#ffffff" },
      "PUT": { "bg": "#f59e0b", "text": "#ffffff" },
      "DELETE": { "bg": "#ef4444", "text": "#ffffff" },
      "PATCH": { "bg": "#8b5cf6", "text": "#ffffff" }
    }
  },

  "design_tokens.components.required_badge": {
    "text": "required",
    "color": "#ef4444",
    "font_size": "0.75rem",
    "font_weight": 500
  },

  "design_tokens.components.external_link_indicator": {
    "icon": "arrow-up-right",
    "size": "12px",
    "position": "top-right of card",
    "color": "#6b7280"
  },

  "design_tokens.components.section_divider": {
    "border": "1px solid #e5e7eb",
    "margin": "2rem 0"
  },

  "design_tokens.components.callout.icons": {
    "info": "info-circle (blue)",
    "warning": "triangle-exclamation (amber)",
    "tip": "lightbulb (green)",
    "note": "info-circle (gray)",
    "danger": "circle-xmark (red)"
  },

  "design_tokens.components.card.grid_variants": {
    "two_column": "repeat(2, 1fr)",
    "three_column": "repeat(3, 1fr)"
  },

  "design_tokens.components.card.typography": {
    "title_size": "1rem",
    "title_weight": 600,
    "description_size": "0.875rem",
    "description_weight": 400,
    "description_color": "#6b7280",
    "icon_size": "24px"
  }
}
```

### Priority 3: Corrections to Existing Tokens

1. **`components.code_block.tab_languages`**: Change from `["TypeScript", "Python", "cURL", "Go", "Rust"]` to `["cURL", "TypeScript", "Python"]` -- cURL is listed first in observed tab order, and Go/Rust were not observed in any screenshot.

2. **`components.callout.variants`**: Add icon specifications to each variant.

3. **`universal_patterns.navigation.top_bar`**: Expand from "Horizontal tab navigation for major sections" to include the full header (logo, search, Ask AI, Support, Dashboard CTA, settings gear) plus the section tab bar as a separate element.

4. **`universal_patterns.every_page_has`**: Add "Copy page button next to H1" and "Section dividers (horizontal rules) between H2 sections".

5. **Add `universal_patterns.pages_without_sidebar`**: Document that some page types (changelog, certain overview/landing pages like MemoryBench) do NOT show the left sidebar.

---

## 10. Summary of Findings

### Accurately Captured (token correct as-is)
- Content max-width, sidebar width, ToC width
- All font families (Inter, JetBrains Mono)
- All heading sizes and weights
- Body text size and line-height
- Background colors (light and dark)
- Card border-radius, padding, icon presence
- Callout border-radius, border-left, padding, all 4 confirmed variants
- Code block border-radius, copy button, filename headers, language tabs
- Steps numbered with vertical connector
- Table horizontal-only borders, non-striped

### Inaccurately Captured (needs correction)
- **Accent color**: Should be blue (#2563eb), not purple (#7c3aed)
- **Code block theme**: Light mode uses a light syntax theme, not one-dark-pro
- **Tab languages default order**: cURL first, then TypeScript, then Python; Go/Rust not observed

### Missing Entirely (needs addition)
- Header bar structure (logo, search, Ask AI, CTA button, settings)
- Section tab navigation bar
- Sidebar internal design (grouping, icons, active states, visibility rules)
- Footer structure (prev/next nav, social icons, powered-by)
- API Reference two-column layout
- Changelog timeline layout
- "Was this page helpful?" feedback widget
- "Copy page" button
- Breadcrumb styling tokens
- HTTP method badges and "required" badges
- External link indicators on cards
- Section divider (horizontal rule) styling
- Callout icons per variant
- Card grid 3-column variant
- Card typography sub-tokens
- Code block AI/explain button
- Code block header bar styling
